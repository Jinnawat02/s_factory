// สร้าง Class เพื่อกำหนดโครงสร้างข้อมูล
class Machine {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String status; // เพิ่มสถานะให้ดูสมจริง (Normal, Warning, Error)

  Machine({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.status,
  });
}

// สร้าง List ข้อมูลจำลอง
final List<Machine> mockMachines = [
  Machine(
    id: 'M001',
    name: 'CNC Milling Machine X1',
    imageUrl: 'https://images.unsplash.com/photo-1565439398532-39c8e76f7f63?auto=format&fit=crop&w=800&q=80',
    description: 'เครื่องกัด CNC ความแม่นยำสูง สำหรับงานโลหะและอลูมิเนียม รองรับ 5 แกน',
    status: 'Normal',
  ),
  Machine(
    id: 'M002',
    name: 'Industrial Robot Arm',
    imageUrl: 'https://images.unsplash.com/photo-1565485406739-168a7f7c462e?auto=format&fit=crop&w=800&q=80',
    description: 'แขนกลสำหรับงานประกอบชิ้นส่วนยานยนต์ รับน้ำหนักได้สูงสุด 50kg',
    status: 'Warning',
  ),
  Machine(
    id: 'M003',
    name: 'Conveyor Belt System',
    imageUrl: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=800&q=80',
    description: 'ระบบสายพานลำเลียงสินค้าในไลน์ผลิต ความยาว 20 เมตร ปรับความเร็วได้',
    status: 'Error',
  ),
  Machine(
    id: 'M004',
    name: 'Hydraulic Press 500T',
    imageUrl: 'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?auto=format&fit=crop&w=800&q=80',
    description: 'เครื่องปั๊มขึ้นรูปไฮดรอลิก แรงดัน 500 ตัน สำหรับงานขึ้นรูปตัวถัง',
    status: 'Normal',
  ),
];