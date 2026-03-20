/// Add routine page for the s_factory application.
///
/// @author Siwakorn Soemchatchroenkan
import 'package:flutter/material.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';
import '../../shared/utils/snackbar_utils.dart';

/// An admin-only form page for adding a new maintenance routine checklist
/// item to a specific machine.
///
/// A routine represents a single repeatable check that mechanics must
/// complete during their maintenance rounds (e.g. *"Daily Oil Check"*).
///
/// On submission the routine is persisted via `ConnectorConnector.createRoutine`
/// and linked to the given [machineId]. Returns `true` to the caller so the
/// parent [MachineDetailPage] can refresh its checklist.
///
/// Example usage:
/// ```dart
/// final result = await Navigator.push<bool>(
///   context,
///   MaterialPageRoute(
///     builder: (_) => AddRoutinePage(
///       machineId: 'abc123',
///       machineName: 'Lathe Machine A1',
///     ),
///   ),
/// );
/// if (result == true) _loadRoutines();
/// ```
class AddRoutinePage extends StatefulWidget {
  /// The unique ID of the machine this routine belongs to.
  final String machineId;

  /// The display name of the machine, shown in the app bar title.
  final String machineName;

  /// Creates an [AddRoutinePage] for the machine identified by [machineId].
  const AddRoutinePage({
    super.key,
    required this.machineId,
    required this.machineName,
  });

  @override
  State<AddRoutinePage> createState() => _AddRoutinePageState();
}

class _AddRoutinePageState extends State<AddRoutinePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  bool _isLoading = false;

  /// Validates the form then submits a new routine to Firebase Data Connect.
  ///
  /// Fields submitted:
  /// - [_title] — required, trimmed routine title
  /// - [_description] — optional, trimmed description / steps
  ///
  /// Pops with `true` on success or shows an error [SnackBar] on failure.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await ConnectorConnector.instance
          .createRoutine(
            machineId: widget.machineId,
            title: _title.trim(),
            description: _description.trim(),
          )
          .execute();

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Routine added successfully');
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Error: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Returns a consistent [InputDecoration] used by both form fields,
  /// with rounded borders in grey (enabled) and white (focused).
  ///
  /// [hint] sets the placeholder text shown inside the field.
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: NavBar(
        title: 'Add Routine — ${widget.machineName}',
        leadingText: 'Back',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ROUTINE TITLE',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _inputDecoration('e.g. Daily Oil Check'),
                style: const TextStyle(color: Colors.white),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter a title'
                    : null,
                onChanged: (value) => _title = value,
              ),
              const SizedBox(height: 24),

              const Text(
                'DESCRIPTION (optional)',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: _inputDecoration(
                  'Steps or notes for this routine...',
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 48),

              Center(
                child: SizedBox(
                  width: 120,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            'Add',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
