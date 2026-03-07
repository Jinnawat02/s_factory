import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';
import '../../mock/request_mock_data.dart';
import '../../shared/widgets/nav_bar.dart';

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

  // Form fields
  String _description = '';
  String? _selectedMechanic;
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  // State management
  bool _isLoadingMechanics = true;
  bool _isSubmitting = false;
  final List<GetMechanicsUsers> _mechanics = [];

  @override
  void initState() {
    super.initState();
    _fetchMechanics();
  }

  // Data fetching
  Future<void> _fetchMechanics() async {
    try {
      final response = await ConnectorConnector.instance
          .getMechanics()
          .execute();
      final mechanics = response.data.users;

      if (!mounted) return;

      setState(() {
        _mechanics.addAll(mechanics);
        _isLoadingMechanics = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoadingMechanics = false);
      _showErrorSnackBar('Error loading mechanics: $e');
    }
  }

  // Date and time pickers
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.input,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => _pickedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _pickedTime = picked);
    }
  }

  // Form submission
  Future<void> _submitRequest() async {
    if (!_validateForm()) return;

    setState(() => _isSubmitting = true);

    try {
      final email = FirebaseAuth.instance.currentUser?.email ?? 'Unknown User';
      final requestDateTime = _buildRequestDateTime();

      // Save to mock data (for backward compatibility)
      _saveMockRequest(email);

      // Save to Firebase Data Connect
      await _saveToDataConnect(email, requestDateTime);

      if (!mounted) return;

      _showSuccessSnackBar('ส่งข้อมูลการแจ้งซ่อมเรียบร้อยแล้ว');
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar('เกิดข้อผิดพลาด: $e');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    if (_pickedDate == null || _pickedTime == null) {
      _showErrorSnackBar('กรุณาเลือกวันและเวลาให้ครบถ้วน');
      return false;
    }

    return true;
  }

  DateTime _buildRequestDateTime() {
    return DateTime(
      _pickedDate!.year,
      _pickedDate!.month,
      _pickedDate!.day,
      _pickedTime!.hour,
      _pickedTime!.minute,
    );
  }

  void _saveMockRequest(String email) {
    final requestId = DateTime.now().millisecondsSinceEpoch.toString();
    final newRequest = {
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
    };
    RequestMockData.addRequest(newRequest);
  }

  Future<void> _saveToDataConnect(
    String email,
    DateTime requestDateTime,
  ) async {
    await ConnectorConnector.instance
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
  }

  // UI helpers
  void _showErrorSnackBar(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccessSnackBar(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: 'แจ้งซ่อม: ${widget.machineName}',
        leadingText: 'Cancel',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDescriptionField(),
              const SizedBox(height: 20),
              _buildMechanicDropdown(),
              const SizedBox(height: 20),
              _buildDatePicker(),
              const SizedBox(height: 20),
              _buildTimePicker(),
              const SizedBox(height: 40),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รายละเอียดอาการเสีย',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'กรอกรายละเอียดปัญหา...',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          validator: (value) =>
              value == null || value.isEmpty ? 'กรุณากรอกรายละเอียด' : null,
          onChanged: (value) => _description = value,
        ),
      ],
    );
  }

  Widget _buildMechanicDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'เลือกช่าง',
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
                'กำลังโหลดข้อมูลช่าง...',
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
            _mechanics.isEmpty ? 'ไม่พบข้อมูลช่างซ่อม' : 'เลือกช่าง',
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
          validator: (val) => val == null ? 'กรุณาเลือกช่าง' : null,
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'เลือกวันที่',
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
                  ? 'กดเพื่อเลือกวันที่'
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

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'เลือกเวลา',
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
                  ? 'กดเพื่อเลือกเวลา'
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

  Widget _buildSubmitButton() {
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
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text('ยืนยันส่งคำร้อง', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
