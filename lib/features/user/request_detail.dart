import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

import '../../dataconnect_generated/generated.dart';
import '../../shared/widgets/nav_bar.dart';

class RequestDetailPage extends StatefulWidget {
  final String requestId;

  const RequestDetailPage({super.key, required this.requestId});

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  bool _isSaving = false;

  GetRequestRequest? _request;
  final List<GetMechanicsUsers> _mechanics = [];

  String? _description;
  String? _selectedMechanic;
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final requestFuture = ConnectorConnector.instance
          .getRequest(id: widget.requestId)
          .execute();
      final mechanicsFuture = ConnectorConnector.instance
          .getMechanics()
          .execute();

      final results = await Future.wait([requestFuture, mechanicsFuture]);
      final requestResult =
          results[0] as QueryResult<GetRequestData, GetRequestVariables>;
      final mechanicsResult = results[1] as QueryResult<GetMechanicsData, void>;

      final request = requestResult.data.request;

      if (!mounted) return;

      if (request != null) {
        setState(() {
          _request = request;
          _description = request.description;
          _selectedMechanic = request.mechanic.email;

          final requestDateTime = request.requestDate.toDateTime().toLocal();
          _pickedDate = DateTime(
            requestDateTime.year,
            requestDateTime.month,
            requestDateTime.day,
          );
          _pickedTime = TimeOfDay(
            hour: requestDateTime.hour,
            minute: requestDateTime.minute,
          );

          _mechanics.addAll(mechanicsResult.data.users);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar('Request not found');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showSnackBar('Error loading data: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _pickedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _pickedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _pickedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _pickedTime = picked);
    }
  }

  Future<void> _saveRequest() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;
    if (_pickedDate == null || _pickedTime == null) {
      _showSnackBar('Please select date and time');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final requestDateTime = DateTime(
      _pickedDate!.year,
      _pickedDate!.month,
      _pickedDate!.day,
      _pickedTime!.hour,
      _pickedTime!.minute,
    );

    try {
      await ConnectorConnector.instance
          .updateRequest(id: widget.requestId)
          .description(_description)
          .mechanicEmail(_selectedMechanic)
          .requestDate(
            Timestamp.fromJson(requestDateTime.toUtc().toIso8601String()),
          )
          .execute();

      if (!mounted) return;
      _showSnackBar('Request updated successfully');
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Error saving data: $e');
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: 'Request',
        leadingText: 'Cancel',
        actions: [
          TextButton(
            onPressed: _isLoading || _isSaving ? null : _saveRequest,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _request == null
          ? const Center(child: Text('Request not found'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMachineImage(),
                    const SizedBox(height: 20),
                    _buildMachineDetails(),
                    const SizedBox(height: 30),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 20),
                    _descriptionField(),
                    const SizedBox(height: 20),
                    _mechanicDropdown(),
                    const SizedBox(height: 20),
                    _datePicker(),
                    const SizedBox(height: 20),
                    _timePicker(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildMachineImage() {
    final imageUrl = _request?.machine.imageUrl;
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            )
          : const Center(
              child: Icon(Icons.settings, size: 50, color: Colors.grey),
            ),
    );
  }

  Widget _buildMachineDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _request?.machine.name ?? 'Unknown Machine',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _request?.machine.description ?? 'No description available',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _descriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Problem Description',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: _description,
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
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter a description'
              : null,
          onChanged: (value) => _description = value,
        ),
      ],
    );
  }

  Widget _mechanicDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Mechanic',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
            prefixIcon: const Icon(Icons.person, color: Colors.white),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          isExpanded: true,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          dropdownColor: Colors.grey[900],
          menuMaxHeight: 300,
          initialValue: _selectedMechanic,
          items: _mechanics.isEmpty
              ? []
              : _mechanics
                    .map(
                      (m) => DropdownMenuItem(
                        value: m.email,
                        child: Text(
                          m.name ?? m.email,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                    .toList(),
          onChanged: _mechanics.isEmpty
              ? null
              : (val) => setState(() => _selectedMechanic = val),
          validator: (val) => val == null ? 'Please select a mechanic' : null,
        ),
      ],
    );
  }

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
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.white),
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
              prefixIcon: const Icon(Icons.access_time, color: Colors.white),
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
}
