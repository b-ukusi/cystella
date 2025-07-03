import 'package:cystella_patients/screens/logsymptomscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/uploaddoc.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  TextEditingController periodLengthController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int cycleLength = 33;
  int periodStartDay = 15;
  int periodLength = 5;
  bool showLogPeriodDialog = false;

  TextEditingController notesController = TextEditingController();

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
  List<String> droptitles2 = ["Low", "Medium", "Heavy", "Blood Clots"];
  List<String> droptitles3 = [
    "Decreased Appetite",
    "Food Cravings",
    "Increased Appetite",
    "No change"
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

  String getPeriodStatus() {
    final now = selectedDate;
    DateTime lastPeriodStart = DateTime(now.year, now.month, periodStartDay);
    if (now.isBefore(lastPeriodStart)) {
      lastPeriodStart = lastPeriodStart.subtract(Duration(days: cycleLength));
    }
    // final periodStartDate =
    //     DateTime(now.year, now.month, periodStartDay); // Assuming current month
    // int diff = now.difference(periodStartDate).inDays;

    // if (diff < 0) {
    //   diff += cycleLength;
    // }

    int cycleDay = now.difference(lastPeriodStart).inDays + 1;

    if (cycleDay <= periodLength) {
      return "Period Day $cycleDay";
    } else {
      int daysLeft = (cycleLength - cycleDay + 1) % cycleLength;
      return "Period in $daysLeft days";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Good Morning, Boyani",
                        style: GoogleFonts.poppins(fontSize: 18)),
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage("images/profile.png"),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.notifications_active)
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                //
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 90,
                    itemBuilder: (context, index) {
                      final date = DateTime.now().add(Duration(days: index));
                      final isSelected = date.day == selectedDate.day &&
                          date.month == selectedDate.month &&
                          date.year == selectedDate.year;

                      final startDate =
                          DateTime(date.year, date.month, periodStartDay);
                      int diff = date.difference(startDate).inDays;
                      if (diff < 0) diff += cycleLength;
                      int cycleDay = (diff % cycleLength) + 1;
                      bool isPeriodDay =
                          cycleDay >= 1 && cycleDay <= periodLength;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedDate = date);
                        },
                        child: Container(
                          width: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.pink[100]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                [
                                  "S",
                                  "M",
                                  "T",
                                  "W",
                                  "Th",
                                  "F",
                                  "S"
                                ][date.weekday - 1],
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${date.day}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //heart shaped display
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
                          Text(getPeriodStatus(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[800],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => showLogPeriodDialog = true),
                      child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(10),
                          child: const Center(
                            child: Text(
                              "Log Period",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(width: 10),
                    // GestureDetector(
                    //   child: Container(
                    //     width: 120,
                    //     decoration: BoxDecoration(
                    //         color: Colors.pink,
                    //         borderRadius: BorderRadius.circular(20)),
                    //     padding: const EdgeInsets.all(10),
                    //     child: Row(
                    //       children: [
                    //         Icon(Icons.upload_file,
                    //             color: Colors.white, size: 18),
                    //         SizedBox(width: 6),
                    //         Text(
                    //           "Upload Doc",
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    UploadDocumentButton(),
                  ],
                ),
                const SizedBox(height: 20),
                // Text("Your Wellbeing Area",
                //     style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                // Text("Log your symptoms today",
                //     style: GoogleFonts.poppins(fontWeight: FontWeight.w300)),
                const SizedBox(height: 16),
                LogSymptomsScreen(),
                // buildDropdown(
                //     "How are you feeling today?",
                //     droptitles,
                //     selectedTitle,
                //     (val) => setState(() => selectedTitle = val)),
                // buildDropdown("Blood Intensity", droptitles2, selectedTitle2,
                //     (val) => setState(() => selectedTitle2 = val)),
                // buildDropdown("Appetite Changes", droptitles3, selectedTitle3,
                //     (val) => setState(() => selectedTitle3 = val)),
                // buildDropdown("Mood Today", droptitles4, selectedTitle4,
                //     (val) => setState(() => selectedTitle4 = val)),
                Text("Notes"),
                TextFormField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    hintText: '+ Additional Notes',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showLogPeriodDialog)
            Center(
              child: Material(
                color: Colors.black54,
                child: Center(
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Log Your Period",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>
                                  setState(() => showLogPeriodDialog = false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: periodLengthController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "How many days does your period last?",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            final length = int.tryParse(
                                periodLengthController.text.trim());
                            if (length != null) {
                              setState(() {
                                periodLength = length;
                                cycleLength = 28 + periodLength;
                                showLogPeriodDialog = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink),
                          child: const Text("Save",
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget buildDropdown(String label, List<String> items, String? selectedValue,
  //     Function(String?) onChanged) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(label),
  //       SizedBox(
  //         width: 400,
  //         height: 40,
  //         child: DropdownButtonFormField<String>(
  //           hint: const Text("Select below"),
  //           value: selectedValue,
  //           items: items
  //               .map((title) => DropdownMenuItem<String>(
  //                     value: title,
  //                     child: Text(title),
  //                   ))
  //               .toList(),
  //           onChanged: onChanged,
  //           decoration: const InputDecoration(
  //             border: OutlineInputBorder(),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //     ],
  //   );
  // }
}
