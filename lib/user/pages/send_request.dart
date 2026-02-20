import 'package:flutter/material.dart';

void main() {
  runApp(const SendRequestApp());
}

class SendRequestApp extends StatelessWidget {
  const SendRequestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Use a modern, professional sans-serif font
        fontFamily: 'Montserrat',
        // Define a primary color palette based on the wireframe's orange
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE69556), // Warm orange from wireframe
          secondary: const Color(0xFFE69556),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE69556),
            foregroundColor: Colors.white,
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE69556), width: 2),
          ),
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIconColor: const Color(0xFFE69556),
        ),
      ),
      home: const SendRequestScreen(),
    );
  }
}

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController(); // Controller for the message
  String? _selectedMechanic;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _messageController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a subtle gradient background
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        title: const Text(
          'Request',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // A soft, modern gradient for the background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFFFF3E0), // Lighter orange at the bottom
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card for the form content to give it depth
                Card(
                  elevation: 2,
                  shadowColor: Colors.orange.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'New Service Request',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: const Color(0xFFE69556),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Request Message
                        TextFormField(
                          controller: _messageController, // Use the controller
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'Describe your request...',
                            labelText: 'Request Message',
                            alignLabelWithHint: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 80.0),
                              child: Icon(Icons.message_outlined),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Select Mechanist
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Select Mechanic',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          value: _selectedMechanic,
                          items: ['John Doe', 'Jane Smith', 'Bob Johnson']
                              .map((mechanic) => DropdownMenuItem(
                            value: mechanic,
                            child: Text(mechanic),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMechanic = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // Select Date
                        TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Select Date',
                            hintText: 'Tap to select date',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          controller: TextEditingController(
                            text: _selectedDate == null
                                ? ''
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          ),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Color(0xFFE69556),
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null && picked != _selectedDate) {
                              setState(() {
                                _selectedDate = picked;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),

                        // Select Time
                        TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Select Time',
                            hintText: 'Tap to select time',
                            prefixIcon: Icon(Icons.access_time_outlined),
                          ),
                          controller: TextEditingController(
                            text: _selectedTime == null
                                ? ''
                                : _selectedTime!.format(context),
                          ),
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Color(0xFFE69556),
                                      onPrimary: Colors.white,
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null && picked != _selectedTime) {
                              setState(() {
                                _selectedTime = picked;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Send Request Button
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Print the message from the controller
                      print('Request Message: ${_messageController.text}');

                      // Process request
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Request Sent Successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    // Gradient for the button itself
                    backgroundColor: const Color(0xFFE69556),
                    shadowColor: const Color(0xFFE69556).withOpacity(0.5),
                  ),
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Send Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
