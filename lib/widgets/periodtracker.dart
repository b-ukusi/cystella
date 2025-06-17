import 'package:flutter/material.dart';

class PeriodTrackerCalendar extends StatefulWidget {
  const PeriodTrackerCalendar({super.key});

  @override
  _PeriodTrackerCalendarState createState() => _PeriodTrackerCalendarState();
}

class _PeriodTrackerCalendarState extends State<PeriodTrackerCalendar> {
  int selectedDay = -1;

  final int cycleLength = 28;
  final int periodLength = 5;
  final int periodStartDay = 20; // e.g. period starts on day 20 of the month

  // Helper to calculate cycle day for a given date
  int getCycleDay(int day) {
    if (day < periodStartDay) {
      // Before the first period start, backtrack to find correct cycle
      int daysSinceLastCycle =
          (day + (31 - periodStartDay)) % cycleLength; // handle wrapping
      return daysSinceLastCycle + 1;
    } else {
      return ((day - periodStartDay) % cycleLength) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> weekDays = ['S', 'M', 'T', 'W', 'TH', 'F', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekdays row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays.map((day) => Text(day)).toList(),
        ),
        SizedBox(height: 12),

        // Scrollable row of month days with cycle logic
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(31, (index) {
              int day = index + 1;
              int cycleDay = getCycleDay(day);
              bool isPeriodDay = cycleDay >= 1 && cycleDay <= periodLength;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDay = day;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  width: 50,
                  height: 60,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedDay == day ? const Color.fromRGBO(255, 255, 255, 1) : null,
                          border: isPeriodDay
                              ? Border.all(
                                  color: Colors.pink,
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Text(
                          '$day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                selectedDay == day ? Colors.pink : Colors.black,
                          ),
                        ),
                      ),

                      // Cycle day badge
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$cycleDay',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.pink[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
