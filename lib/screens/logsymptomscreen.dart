import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogSymptomsScreen extends StatefulWidget {
  const LogSymptomsScreen({super.key});

  @override
  State<LogSymptomsScreen> createState() => _LogSymptomsScreenState();
}

class _LogSymptomsScreenState extends State<LogSymptomsScreen> {
  bool? _painResponse;
  bool? _periodIrregularity;
  bool? _bloating;
  bool? _painDuringSex;
  bool? _frequentUrination;
  double _fatigueLevel = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you feeling today?',
            style: GoogleFonts.poppins(
                fontSize: 18,
              ),

          ),
          const SizedBox(height: 16),
          _buildYesNoCard(
            question: "Are you experiencing lower abdominal pain?",
            value: _painResponse,
            onChanged: (val) => setState(() => _painResponse = val),
            
          ),
          _buildYesNoCard(
            question: "Have you noticed irregular or missed periods?",
            value: _periodIrregularity,
            onChanged: (val) => setState(() => _periodIrregularity = val),
          ),
          _buildYesNoCard(
            question: "Do you feel bloated after small meals?",
            value: _bloating,
            onChanged: (val) => setState(() => _bloating = val),
          ),
          _buildYesNoCard(
            question: "Do you experience pain during sexual activity?",
            value: _painDuringSex,
            onChanged: (val) => setState(() => _painDuringSex = val),
          ),
          _buildYesNoCard(
            question: "Do you need to urinate frequently?",
            value: _frequentUrination,
            onChanged: (val) => setState(() => _frequentUrination = val),
          ),
          _buildSliderCard(
            label: "How fatigued have you felt today?",
            value: _fatigueLevel,
            onChanged: (val) => setState(() => _fatigueLevel = val),
          ),
          const SizedBox(height: 24),
          // ElevatedButton(
          //   onPressed: () {
          //     // You can add your submission logic here
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //           content: Text("Symptoms logged successfully.")),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.pinkAccent,
          //     minimumSize: const Size(double.infinity, 48),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12)),
          //   ),
          //   child: Text("Submit", style: GoogleFonts.poppins(
          //     fontWeight: FontWeight.w600,
          //   ),),
          // ),
        ],
      ),
    );
  }

  Widget _buildYesNoCard({
    required String question,
    required bool? value,
    required Function(bool?) onChanged,
  }) {
    return Card(
      color: Colors.pink[100],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            question,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: RadioListTile<bool>(
                title: const Text("Yes"),
                value: true,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: const Text("No"),
                value: false,
                groupValue: value,
                onChanged: onChanged,
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _buildSliderCard({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            label,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Slider(
            value: value,
            onChanged: onChanged,
            min: 0,
            max: 5,
            divisions: 5,
            label: value.round().toString(),
            activeColor: Colors.pinkAccent,
          ),
        ]),
      ),
    );
  }
}
