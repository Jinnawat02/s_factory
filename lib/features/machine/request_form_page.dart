import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
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

  // ตัวแปรสำหรับเก็บข้อมูล
  String _description = '';
  String? _selectedMechanic;
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  bool _isLoadingMechanics = true;
  final List<GetMechanicsUsers> _mechanics = [];

  @override
  void initState() {
    super.initState();
    _fetchMechanics();
  }

  Future<void> _fetchMechanics() async {
    try {
      final response = await ConnectorConnector.instance
          .getMechanics()
          .execute();
      final mechanics = response.data.users;

      if (mounted) {
        setState(() {
          _mechanics.addAll(mechanics);
          _isLoadingMechanics = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingMechanics = false;
      });
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading mechanics: $e')));
    }
  }

  // ฟังก์ชันเลือกวันที่
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // ห้ามเลือกวันย้อนหลัง
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _pickedDate = picked);
    }
  }

  // ฟังก์ชันเลือกเวลา
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _pickedTime = picked);
    }
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
              const Text(
                'รายละเอียดอาการเสีย',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'กรอกรายละเอียดปัญหา...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'กรุณากรอกรายละเอียด'
                    : null,
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 20),

              const Text(
                'เลือกช่าง',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _isLoadingMechanics
                  ? DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'loading',
                          child: Text('กำลังโหลดข้อมูลช่าง...'),
                        ),
                      ],
                      initialValue: 'loading',
                      onChanged: null,
                    )
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      hint: Text(
                        _mechanics.isEmpty
                            ? 'ไม่พบข้อมูลช่างซ่อม'
                            : 'เลือกช่าง',
                      ),
                      initialValue: _selectedMechanic,
                      items: _mechanics.isEmpty
                          ? []
                          : _mechanics
                                .map(
                                  (m) => DropdownMenuItem(
                                    value: m.email,
                                    child: Text(m.name ?? m.email),
                                  ),
                                )
                                .toList(),
                      onChanged: _mechanics.isEmpty
                          ? null
                          : (val) => setState(() => _selectedMechanic = val),
                      validator: (val) => val == null ? 'กรุณาเลือกช่าง' : null,
                    ),
              const SizedBox(height: 20),

              // ส่วนเลือกวันที่แบบจิ้มปฏิทิน
              const Text(
                'เลือกวันที่',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _pickedDate == null
                        ? 'กดเพื่อเลือกวันที่'
                        : DateFormat('dd/MM/yyyy').format(_pickedDate!),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ส่วนเลือกเวลาแบบจิ้มนาฬิกา
              const Text(
                'เลือกเวลา',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.access_time),
                  ),
                  child: Text(
                    _pickedTime == null
                        ? 'กดเพื่อเลือกเวลา'
                        : _pickedTime!.format(context),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _pickedDate != null &&
                          _pickedTime != null) {
                        // 1. Fetch User Email
                        final String email =
                            FirebaseAuth.instance.currentUser?.email ??
                            'Unknown User';

                        final DateTime requestDateTime = DateTime(
                          _pickedDate!.year,
                          _pickedDate!.month,
                          _pickedDate!.day,
                          _pickedTime!.hour,
                          _pickedTime!.minute,
                        );

                        // Save to Mock Data Store (optional, keeping for UI backward compatibility if needed)
                        final String requestIdMock = DateTime.now()
                            .millisecondsSinceEpoch
                            .toString();
                        final newRequest = {
                          'request_id': requestIdMock,
                          'email': email,
                          'machine_id': widget.machineID,
                          'machine_name': widget.machineName,
                          'description': _description,
                          'selectedMechanic': _selectedMechanic,
                          'pickedDate': DateFormat(
                            'yyyy-MM-dd',
                          ).format(_pickedDate!),
                          'pickedTime': _pickedTime!.format(context),
                          'status': 'pending',
                          'timestamp': DateTime.now().toIso8601String(),
                        };
                        RequestMockData.addRequest(newRequest);

                        try {
                          print(
                            '--- STARTING REQUEST SUBMISSION TO CLOUD FUNCTION ---',
                          );

                          final funcResponse = await FirebaseFunctions.instance
                              .httpsCallable('submitRepairRequest')
                              .call({
                                'machineId': widget.machineID,
                                'description': _description,
                                'mechanicEmail': _selectedMechanic,
                                'requestDate': requestDateTime
                                    .toUtc()
                                    .toIso8601String(),
                              });

                          print(
                            '-> Function Success, Response: \${funcResponse.data}',
                          );
                          print('--- END REQUEST SUBMISSION ---');

                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'ส่งข้อมูลการแจ้งซ่อมเรียบร้อยแล้ว',
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          print('-> Function Error: $e');
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
                          );
                        }
                      } else if (_pickedDate == null || _pickedTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('กรุณาเลือกวันและเวลาให้ครบถ้วน'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ยืนยันส่งคำร้อง',
                      style: TextStyle(fontSize: 16),
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
