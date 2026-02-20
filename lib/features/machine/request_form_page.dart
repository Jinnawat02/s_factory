import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../mock/mechanics_mock_data.dart';
import '../../shared/widgets/nav_bar.dart';

class RequestFormPage extends StatefulWidget {
  final String machineName;
  final String machineID;

  const RequestFormPage({
    super.key,
    required this.machineName,
    required this.machineID
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

  final List<String> _mechanics = [];

  @override
  initState() {
    super.initState();

    for (var item in MechanicsMockData.mechanics) {
      _mechanics.add(item['name'].toString());
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
              const Text('รายละเอียดอาการเสีย', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'กรอกรายละเอียดปัญหา...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) => value == null || value.isEmpty ? 'กรุณากรอกรายละเอียด' : null,
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 20),

              const Text('เลือกช่าง', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person),
                ),
                initialValue: _selectedMechanic,
                items: _mechanics.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (val) => setState(() => _selectedMechanic = val),
                validator: (val) => val == null ? 'กรุณาเลือกช่าง' : null,
              ),
              const SizedBox(height: 20),

              // ส่วนเลือกวันที่แบบจิ้มปฏิทิน
              const Text('เลือกวันที่', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
              const Text('เลือกเวลา', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _pickedDate != null && _pickedTime != null) {
                        // ส่งข้อมูลสำเร็จ
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ส่งข้อมูลการแจ้งซ่อมเรียบร้อยแล้ว')),
                        );
                        Navigator.pop(context);

                        print(_description);
                        print( _pickedDate);
                        print(_pickedTime);

                      } else if (_pickedDate == null || _pickedTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('กรุณาเลือกวันและเวลาให้ครบถ้วน')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('ยืนยันส่งคำร้อง', style: TextStyle(fontSize: 16)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}