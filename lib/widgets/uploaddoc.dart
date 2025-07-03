import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadDocumentButton extends StatefulWidget {
  const UploadDocumentButton({super.key});

  @override
  State<UploadDocumentButton> createState() => _UploadDocumentButtonState();
}

class _UploadDocumentButtonState extends State<UploadDocumentButton> {
  File? selectedFile;
  bool isUploading = false;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void sendFilePlaceholder() {
    // Placeholder for sending logic
    setState(() {
      isUploading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Send clicked (mock logic)")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: pickFile,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: const [
                Icon(Icons.upload_file, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text("Upload Doc", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (selectedFile != null)
          Text("Selected: ${selectedFile!.path.split('/').last}"),
        const SizedBox(height: 8),
        if (selectedFile != null)
          ElevatedButton(
            onPressed: isUploading ? null : sendFilePlaceholder,
            child: isUploading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Send"),
          ),
      ],
    );
  }
}
