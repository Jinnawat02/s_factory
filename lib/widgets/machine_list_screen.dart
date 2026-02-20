import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/machine_data.dart';
import '../user/pages/machine_info.dart'; // import ไฟล์ข้อมูลเดิม

class MachineListScreen extends StatelessWidget {
  const MachineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รายการเครื่องจักร"),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      // ใช้ LayoutBuilder เพื่อเช็คขนาดหน้าจอ (เผื่อปรับแต่งเพิ่มเติม)
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: mockMachines.length,

            // --- หัวใจสำคัญของความ Responsive ---
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400, // การ์ดแต่ละใบกว้างไม่เกิน 400px
              childAspectRatio: 0.75,  // อัตราส่วน กว้าง:สูง (ปรับเลขนี้ถ้าการ์ดอ้วน/ผอมไป)
              crossAxisSpacing: 16,    // ระยะห่างแนวนอน
              mainAxisSpacing: 16,     // ระยะห่างแนวตั้ง
            ),
            // ------------------------------------

            itemBuilder: (context, index) {
              final machine = mockMachines[index];
              return MachineCard(machine: machine);
            },
          );
        },
      ),
    );
  }
}

class MachineCard extends StatelessWidget {
  final Machine machine;

  const MachineCard({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. ส่วนรูปภาพ (ใช้ Expanded เพื่อให้ยืดเต็มพื้นที่ที่เหลือด้านบน)
          Expanded(
            flex: 3, // ให้รูปภาพกินพื้นที่ 3 ส่วน
            child: Stack(
              fit: StackFit.expand, // ให้รูปขยายเต็มกรอบ
              children: [
                Image.network(
                  machine.imageUrl,
                  fit: BoxFit.cover, // crop รูปให้พอดี ไม่เบี้ยว
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(machine.status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      machine.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. ส่วนเนื้อหา
          Expanded(
            flex: 2, // ให้เนื้อหากินพื้นที่ 2 ส่วน
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดระยะห่างให้สวยงาม
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        machine.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        machine.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // ปุ่ม Action
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MachineDetailScreen(machine: machine),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 0), // ลดความสูงปุ่มนิดหน่อย
                      ),
                      child: const Text("ดูรายละเอียด"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Normal': return Colors.green;
      case 'Warning': return Colors.orange;
      case 'Error': return Colors.red;
      default: return Colors.grey;
    }
  }
}