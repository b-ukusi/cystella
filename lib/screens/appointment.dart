import 'dart:ui';
import 'package:cystella_patients/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int currentIndex = 2;
  DateTime today = DateTime.now();
  final Map<DateTime, List<String>> bookedSlots = {};
  String? selectedTime;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = DateTime(day.year, day.month, day.day);
      selectedTime = null;
    });
  }

  bool _isFullyBooked(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return bookedSlots[key]?.length == 18;
  }

  List<String> getAvailableTimes(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    final booked = bookedSlots[key] ?? [];
    return List.generate(18, (index) {
      final hour = 8 + (index ~/ 2);
      final minute = (index % 2) * 30;
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }).where((time) => !booked.contains(time)).toList();
  }

  void _bookTime(String time) {
    final key = DateTime(today.year, today.month, today.day);
    setState(() {
      bookedSlots.putIfAbsent(key, () => []);
      bookedSlots[key]!.add(time);
      selectedTime = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: CustomizedColors.primarycolor,
      content: Text(
        'Booked $time on ${key.toLocal().toString().split(" ")[0]}',
        style: GoogleFonts.poppins(
            color: CustomizedColors.textcolor1, fontWeight: FontWeight.w500),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final availableTimes = getAvailableTimes(today);
    final hours = availableTimes.map((t) => t.split(":")[0]).toSet().toList();
    final minutes = ["00", "30"];

    return Scaffold(
      backgroundColor: CustomizedColors.bgcolor,
      appBar: AppBar(
        title: Center(child: Text('Book Appointment')),
        backgroundColor: CustomizedColors.bgcolor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.all,
            headerStyle:
                HeaderStyle(titleCentered: true, formatButtonVisible: false),
            rowHeight: 40,
            focusedDay: today,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2025, 6, 13),
            lastDay: DateTime.utc(2026, 6, 13),
            onDaySelected: (day, focusedDay) {
              if (!_isFullyBooked(day) && day.weekday <= 5) {
                _onDaySelected(day, focusedDay);
              }
            },
            enabledDayPredicate: (day) =>
                day.weekday <= 5 && !_isFullyBooked(day),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                if (!_isFullyBooked(day) && day.weekday <= 5) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomizedColors.bgcolor,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(child: Text('${day.day}')),
                  );
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: 220,
                        height: 150,
                        decoration: BoxDecoration(
                          color: CustomizedColors.bgcolor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 80,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            final hour = hours[index];
                            final possibleTimes =
                                minutes.map((m) => "$hour:\$m").toList();
                            selectedTime = possibleTimes.firstWhere(
                              (t) => getAvailableTimes(today).contains(t),
                              orElse: () => "",
                            );
                            setState(() {});
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: hours.length,
                            builder: (context, index) => Center(
                              child: Text(
                                hours[index],
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(":", style: TextStyle(fontSize: 28)),
                      SizedBox(width: 10),
                      SizedBox(
                        height: 150,
                        width: 80,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            final min = minutes[index];
                            final h =
                                selectedTime?.split(":")[0] ?? hours.first;
                            final newTime = "$h: $min";
                            if (getAvailableTimes(today).contains(newTime)) {
                              setState(() {
                                selectedTime = newTime;
                              });
                            }
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: minutes.length,
                            builder: (context, index) => Center(
                              child: Text(
                                minutes[index],
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (selectedTime != null) SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomizedColors.primarycolor,
                foregroundColor: Colors.white,
              ),
              onPressed: () => _bookTime(selectedTime!),
              child: Text('Book $selectedTime Appointment'),
            ),
          ),
          SizedBox(height: 100)
        ],
      ),
    );
  }
}
