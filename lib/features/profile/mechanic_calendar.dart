import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../dataconnect_generated/generated.dart';

class MechanicCalendar extends StatelessWidget {
  final String mechanicEmail;

  const MechanicCalendar({
    super.key,
    required this.mechanicEmail,
  });

  Color _getColorByStatus(String? status) {
    switch (status) {
      case 'Fixed':
        return Colors.green;
      case 'Pending':
        return Colors.yellow;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  DateTime _convertTimestamp(Timestamp ts) {
    return DateTime.fromMillisecondsSinceEpoch(ts.seconds * 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(width: 4, color: Colors.black),
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
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<QueryResult<GetRequestsByMechanicEmailData, GetRequestsByMechanicEmailVariables>>(
              future: ConnectorConnector.instance
                  .getRequestsByMechanicEmail(email: mechanicEmail)
                  .execute(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading calendar: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final requests = snapshot.data?.data.requests ?? [];

                final appointments = requests.map((request) {
                  final date = _convertTimestamp(request.requestDate);
                    return Appointment(
                      startTime: date,
                      endTime: date.add(const Duration(hours: 1)),
                      startTimeZone: 'Asia/Bangkok',
                      endTimeZone: 'Asia/Bangkok',
                      subject: "${request.machine.name!}: ${request.description!}",
                      color: _getColorByStatus(request.status),
                    );
                }).toList();

                return SfCalendar(
                  view: CalendarView.month,
                  timeZone: 'Asia/Bangkok',
                  dataSource: MechanicDataSource(appointments),
                  todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    agendaStyle: AgendaStyle(
                      appointmentTextStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                      dateTextStyle: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MechanicDataSource extends CalendarDataSource {
  MechanicDataSource(List<Appointment> source) {
    appointments = source;
  }
}