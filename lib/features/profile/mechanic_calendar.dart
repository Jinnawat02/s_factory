import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MechanicCalendar extends StatelessWidget {
  const MechanicCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          width: 4,
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Center(
              child: Text(
                'Calendar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          /// Calendar widget here
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: MechanicDataSource(_getAppointments()),

              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),

              todayHighlightColor: Colors.blue,

              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Example events

  /// Green for status 'Fixed'
  /// Yellow for status 'Pending'

  List<Appointment> _getAppointments() {
    final DateTime today = DateTime.now();

    return [
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine A',
        color: Colors.green,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine B',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine C',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine D',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine C',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine D',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine C',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(hours: 2)),
        endTime: today.add(const Duration(hours: 3)),
        subject: 'Inspect Machine D',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(days: 1, hours: 1)),
        endTime: today.add(const Duration(days: 1, hours: 2)),
        subject: 'Maintenance Machine E',
        color: Colors.yellow,
      ),
      Appointment(
        startTime: today.add(const Duration(days: 2)),
        endTime: today.add(const Duration(days: 2, hours: 2)),
        subject: 'Repair Machine F',
        color: Colors.yellow,
      ),
    ];
  }
}

class MechanicDataSource extends CalendarDataSource {
  MechanicDataSource(List<Appointment> source) {
    appointments = source;
  }
}