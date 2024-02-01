import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_tailwindcss_defaults/colors.dart";
import "package:google_fonts/google_fonts.dart";

class EditCriminal extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const EditCriminal({super.key, required this.toggleSecondBody});

  @override
  State<EditCriminal> createState() => _EditCriminal();
}

class _EditCriminal extends State<EditCriminal> {
  late FilePickerResult? result;
  File? image;
  final name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => widget.toggleSecondBody(),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: TailwindColors.blueGray.shade600,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Add Criminal Details",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      fontSize: 20, color: TailwindColors.blueGray.shade600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  image!,
                  width: 200,
                  height: 200,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image);
                if (result != null) {
                  setState(() => image = File(result.files.single.path!));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: TailwindColors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                "Upload",
                style: GoogleFonts.firaSans(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Input(
              controller: name,
              label: "Name",
              text: "Enter Name",
            ),
            Input(
              controller: name,
              label: "Crime History",
              text: "Enter Crime History",
            ),
            Input(
              controller: name,
              text: "Enter Place",
              label: "Place",
            ),
            Input(
              controller: name,
              text: "Enter Date",
              label: "Date",
            ),
            Input(
              controller: name,
              text: "Enter Time",
              label: "Time",
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: TailwindColors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      "Reset",
                      style: GoogleFonts.firaSans(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: TailwindColors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      "Save",
                      style: GoogleFonts.firaSans(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String text;
  final String label;
  final TextEditingController controller;
  const Input(
      {super.key,
      required this.controller,
      required this.text,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.start,
            style: GoogleFonts.firaSans(
                fontSize: 18, color: TailwindColors.blueGray.shade600),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
              color: TailwindColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 2,
                    color: TailwindColors.blueGray.shade100)
              ],
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: text,
                // labelText: text,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: TailwindColors.blueGray)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: TailwindColors.blue.shade600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
