// mock_data.dart
class MockDatabase {
  // ข้อมูลจำลอง (List of Maps)
  static List<Map<String, dynamic>> requests = [
    {
      'id': '1',
      'title': 'แอร์ไม่เย็น (ห้อง 101)',
      'status': 'pending', // สถานะ: รอรับงาน
      'owner_id': 'user1',
      'time': '10:00',
    },
    {
      'id': '2',
      'title': 'ท่อน้ำรั่ว (ห้องครัว)',
      'status': 'fixing', // สถานะ: กำลังซ่อม
      'owner_id': 'user2',
      'time': '11:30',
    },
    {
      'id': '3',
      'title': 'ไฟกระพริบ (โรงรถ)',
      'status': 'done', // สถานะ: เสร็จแล้ว
      'owner_id': 'user1',
      'time': 'Yesterday',
    },
  ];
}