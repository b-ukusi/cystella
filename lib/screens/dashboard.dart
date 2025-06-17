import 'package:cystella_patients/themes/colors.dart';
import 'package:cystella_patients/widgets/periodtracker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  int currentIndex = 0;
  final int periodStartDay = 15;
  final int cycleLength = 28;
  TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? selectedTitle;
    String? selectedTitle2;
    String? selectedTitle3;
    String? selectedTitle4;
    List<String> droptitles = [
      "All good",
      "Cramps",
      "Fatigue",
      "Cravings",
      "Headache",
      "Bloating"
    ];
    List<String> droptitles2 = [
      "Low",
      "Medium",
      "Heavy",
      "Blood Clots",
    ];
    List<String> droptitles3 = [
      "Decreased Appetite",
      "Food Cravings",
      "Increased Appetite",
      "No change",
    ];
    List<String> droptitles4 = [
      "Neutral",
      "Happy",
      "Angry",
      "Sad",
      "Worried",
      "Calm",
      "Anxious",
      "Confused"
    ];
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Good Morning, Boyani", style: GoogleFonts.poppins()),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage("images/image.png"),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.notification_important)
                    ],
                  )
                ],
              ),
              PeriodTrackerCalendar(),
              SizedBox(height: 10),
              // Heart with next period info
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink[100],
                      size: 260,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Period in',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.pink[700],
                          ),
                        ),
                        Text(
                          '${daysUntilNextPeriod()} days',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: CustomizedColors.primarycolor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Log Period",
                              style: TextStyle(
                                  color: CustomizedColors.textcolor1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Wellbeing",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text("Log your symptoms today",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Text("How are you feeling today?"),
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      hint: Text("Select below"),
                      value: selectedTitle,
                      items: droptitles
                          .map((title) => DropdownMenuItem<String>(
                                value: title,
                                child: Text(title),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTitle = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  Text("Blood Intensity"),
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      hint: Text("Select below"),
                      value: selectedTitle2,
                      items: droptitles2
                          .map((title) => DropdownMenuItem<String>(
                                value: title,
                                child: Text(title),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTitle2 = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  Text("Appetite Changes"),
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      hint: Text("Select below"),
                      value: selectedTitle3,
                      items: droptitles3
                          .map((title) => DropdownMenuItem<String>(
                                value: title,
                                child: Text(title),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTitle3 = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  Text("Moood Today"),
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      hint: Text("Select below"),
                      value: selectedTitle4,
                      items: droptitles4
                          .map((title) => DropdownMenuItem<String>(
                                value: title,
                                child: Text(title),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTitle4 = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  Text("Notes"),
                  TextFormField(
                    controller: notesController,
                    decoration: InputDecoration(
                      hintText: '+ Additional Notes',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: null,
                  ),
                  Center(
                    child: Container(
                      width: 200,
                        decoration: BoxDecoration(
                            color: CustomizedColors.primarycolor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: CustomizedColors.textcolor1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int daysUntilNextPeriod() {
    int today = DateTime.now().day;
    if (today <= periodStartDay) {
      return periodStartDay - today;
    } else {
      return (cycleLength - (today - periodStartDay));
    }
  }
}
