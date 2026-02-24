class MachineMockData {
  static final List<Map<String, String>> machines = [
    {
      'name': 'เครื่องปั๊มไฮดรอลิก A1',
      'id': 'ewfw7fw1e165w6f66f',
      'description': 'ใช้สำหรับการขึ้นรูปโลหะหนัก สถานะการทำงานปกติ',
      'imageUrl': 'https://picsum.photos/200?random=1',
    },
    {
      'name': 'สายพานลำเลียง 02',
      'id': 'soaapmfpm0vqomowvmeo8d8vd',
      'description': 'ความเร็วคงที่ 2.5 m/s ตรวจเช็คล่าสุดเมื่อ 2 วันก่อน',
      'imageUrl': 'https://picsum.photos/200?random=2',
    },
    {
      'name': 'เครื่องตัดเลเซอร์ X-Series',
      'id': 'gr7w8h859wew96fwsdpmwo',
      'description': 'ต้องการการบำรุงรักษาด่วน (Maintenance Required)',
      'imageUrl': 'https://picsum.photos/200?random=3',
    },
    {
      'name': 'test',
      'id': 'riowpomgw8we5f1w95w9',
      'description': 'test',
      'imageUrl': 'https://picsum.photos/200?random=4',
    },
  ];

  // Mock data for machine checklists, mapped by machine 'id'
  static final Map<String, List<Map<String, dynamic>>> checklists = {
    'ewfw7fw1e165w6f66f': [
      {
        'title': 'Check Engine Oil',
        'subtitle': 'Ensure oil level is normal',
        'isDone': false,
      },
      {
        'title': 'Filter Check',
        'subtitle': 'Check for dust and replace if necessary',
        'isDone': false,
      },
      {
        'title': 'Power Cable',
        'subtitle': 'Inspect for signs of wear or damage',
        'isDone': false,
      },
      {
        'title': 'Cooling System',
        'subtitle': 'Check coolant levels',
        'isDone': false,
      },
    ],
    'soaapmfpm0vqomowvmeo8d8vd': [
      {
        'title': 'Belt Tension',
        'subtitle': 'Check if the conveyor belt tension is optimal',
        'isDone': false,
      },
      {
        'title': 'Motor Temperature',
        'subtitle': 'Ensure motor is not overheating',
        'isDone': false,
      },
      {
        'title': 'Lubrication',
        'subtitle': 'Lubricate moving parts and bearings',
        'isDone': false,
      },
    ],
    'gr7w8h859wew96fwsdpmwo': [
      {
        'title': 'Laser Alignment',
        'subtitle': 'Verify the alignment of the laser cutting head',
        'isDone': false,
      },
      {
        'title': 'Lens Cleaning',
        'subtitle': 'Clean the focal lens carefully',
        'isDone': false,
      },
      {
        'title': 'Gas Pressure',
        'subtitle': 'Check assist gas pressure levels',
        'isDone': false,
      },
      {
        'title': 'Exhaust System',
        'subtitle': 'Ensure the exhaust is venting properly',
        'isDone': false,
      },
    ],
    'riowpomgw8we5f1w95w9': [
      {'title': 'General Check 1', 'subtitle': 'Test test 1', 'isDone': false},
      {'title': 'General Check 2', 'subtitle': 'Test test 2', 'isDone': false},
    ],
  };

  // Method to update a checklist for a given machine
  static void updateChecklist(
    String machineId,
    List<Map<String, dynamic>> newChecklist,
  ) {
    if (checklists.containsKey(machineId)) {
      // Deep copy the incoming data back into our mock storage
      checklists[machineId] = newChecklist
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
  }
}
