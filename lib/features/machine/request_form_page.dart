/// Repair request form for the s_factory application.
///
/// This page allows staff members to submit a repair request for a specific machine.
/// It includes fields for problem description, mechanic selection, and scheduled date/time.
///
/// @author Jinnawat Janngam
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

import '../../../dataconnect_generated/generated.dart';
import '../../mock/request_mock_data.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../shared/utils/snackbar_utils.dart';

/// A widget that provides a form for creating a new repair request.
///
/// The [machineName] and [machineID] are required to identify the target machine.
class RequestFormPage extends StatefulWidget {
  final String machineName;
  final String machineID;

  const RequestFormPage({
    super.key,
    required this.machineName,
    required this.machineID,
  });

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  String _description = '';
  String? _selectedMechanic;
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  bool _isLoadingMechanics = true;
  final List<GetMechanicsUsers> _mechanics = [];

  /// Combines [_pickedDate] and [_pickedTime] into a single [DateTime] object.
  DateTime get _requestDateTime => DateTime(
    _pickedDate!.year,
    _pickedDate!.month,
    _pickedDate!.day,
    _pickedTime!.hour,
    _pickedTime!.minute,
  );

  @override
  void initState() {
    super.initState();
    _fetchMechanics();
  }

  /// Fetches the list of available mechanics from the database.
  Future<void> _fetchMechanics() async {
    try {
      final response =
      await ConnectorConnector.instance.getMechanics().execute();

      if (!mounted) return;

      setState(() {
        _mechanics.addAll(response.data.users);
        _isLoadingMechanics = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoadingMechanics = false);

      SnackBarUtils.showError(context, 'Error loading mechanics: $e');
    }
  }

  /// Opens a date picker dialog to select the repair date.
  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => _pickedDate = picked);
    }
  }

  /// Opens a time picker dialog to select the repair time.
  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _pickedTime = picked);
    }
  }

  /// Validates the form and submits the repair request to Firebase.
  ///
  /// This process includes:
  /// 1. Saving to local mock data (for testing/history).
  /// 2. Creating the request in the Data Connect database.
  /// 3. Creating a maintenance log entry.
  /// 4. Notifying the assigned mechanic via a Cloud Function.
  Future<void> _submitRequest() async {

    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    if (_pickedDate == null || _pickedTime == null) {
      SnackBarUtils.showError(context, 'Please select both date and time.');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final email =
        FirebaseAuth.instance.currentUser?.email ?? 'Unknown User';

    final requestDateTime = _requestDateTime;

    try {

      final requestId = DateTime.now().millisecondsSinceEpoch.toString();

      // Add to mock data
      RequestMockData.addRequest({
        'request_id': requestId,
        'email': email,
        'machine_id': widget.machineID,
        'machine_name': widget.machineName,
        'description': _description,
        'selectedMechanic': _selectedMechanic,
        'pickedDate': DateFormat('yyyy-MM-dd').format(_pickedDate!),
        'pickedTime': _pickedTime!.format(context),
        'status': 'pending',
        'timestamp': DateTime.now().toIso8601String(),
      });

      // Create request in database
      final result = await ConnectorConnector.instance
          .createRequest(
        userEmail: email,
        machineId: widget.machineID,
        description: _description,
        requestDate: Timestamp.fromJson(
          requestDateTime.toUtc().toIso8601String(),
        ),
        mechanicEmail: _selectedMechanic!,
      )
          .execute();

      final requestIdGenerated = result.data.request_insert.id;

      // Create maintenance log
      await ConnectorConnector.instance
          .createMaintainLog(
        title: 'Created Request: $_description',
        isDone: false,
        machineId: widget.machineID,
      )
          .execute();

      // Notify mechanic via FCM
      try {
        await FirebaseFunctions.instance
            .httpsCallable('notifyMechanic')
            .call({
          'mechanicEmail': _selectedMechanic!,
          'requestId': requestIdGenerated,
        });
      } catch (e) {
        debugPrint('FCM failed: $e');
      }

      if (!mounted) return;

      SnackBarUtils.showSuccess(context, 'Repair request submitted successfully.');

      Navigator.pop(context);

    } catch (e) {

      if (!mounted) return;

      SnackBarUtils.showError(context, 'An error occurred: $e');

    } finally {

      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: NavBar(
        title: 'Repair Request: ${widget.machineName}',
        leadingText: 'Cancel',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _descriptionField(),

              const SizedBox(height: 20),

              _mechanicDropdown(),

              const SizedBox(height: 20),

              _datePicker(),

              const SizedBox(height: 20),

              _timePicker(),

              const SizedBox(height: 40),

              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the description input field.
  Widget _descriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          'Problem Description',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter problem details...',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) =>
          value == null || value.isEmpty
              ? 'Please enter a description'
              : null,
          onChanged: (value) => _description = value,
        ),
      ],
    );
  }

  /// Builds the dropdown for selecting a mechanic.
  Widget _mechanicDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Mechanic',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        _isLoadingMechanics
            ? DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          items: const [
            DropdownMenuItem(
              value: 'loading',
              child: Text(
                'Loading mechanics...',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
          ],
          value: 'loading',
          onChanged: null,
        )
            : DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: _selectedMechanic != null ? Colors.white : Colors.grey,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          isExpanded: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          dropdownColor: Colors.white,
          menuMaxHeight: 300,
          hint: Text(
            _mechanics.isEmpty ? 'No mechanics found' : 'Select mechanic',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          value: _selectedMechanic,
          items: _mechanics.isEmpty
              ? []
              : _mechanics
              .map((m) => DropdownMenuItem(
            value: m.email,
            child: Text(
              m.name ?? m.email,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ))
              .toList(),
          selectedItemBuilder: (BuildContext context) {
            return _mechanics.map((m) {
              return Text(
                m.name ?? m.email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              );
            }).toList();
          },
          onChanged: _mechanics.isEmpty
              ? null
              : (val) => setState(() => _selectedMechanic = val),
          validator: (val) => val == null ? 'Please select a mechanic' : null,
        ),
      ],
    );
  }

  /// Builds the date selector widget.
  Widget _datePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white, width: 2),
              ),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: _pickedDate == null ? Colors.grey : Colors.white,
              ),
            ),
            child: Text(
              _pickedDate == null
                  ? 'Please select a date'
                  : DateFormat('dd/MM/yyyy').format(_pickedDate!),
              style: TextStyle(
                color: _pickedDate == null ? Colors.grey : Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the time selector widget.
  Widget _timePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectTime(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white, width: 2),
              ),
              prefixIcon: Icon(
                Icons.access_time,
                color: _pickedTime == null ? Colors.grey : Colors.white,
              ),
            ),
            child: Text(
              _pickedTime == null
                  ? 'Please select a time'
                  : _pickedTime!.format(context),
              style: TextStyle(
                color: _pickedTime == null ? Colors.grey : Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the submit button for the form.
  Widget _submitButton() {
    return Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _submitRequest,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isSubmitting
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            ),
          )
              : const Text(
            'Submit Request',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
