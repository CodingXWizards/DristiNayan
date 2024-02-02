import "dart:io";
import "package:dristi_nayan/Screens/Components/date_selector_widget.dart";
import "package:flutter/services.dart";
import "package:http/http.dart" as http;
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_tailwindcss_defaults/colors.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:image/image.dart' as img;

class EditCriminal extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const EditCriminal({super.key, required this.toggleSecondBody});

  @override
  State<EditCriminal> createState() => _EditCriminal();
}

class _EditCriminal extends State<EditCriminal> {
  late FilePickerResult? result;
  File? image;
  final TextEditingController name = TextEditingController();
  final TextEditingController crimeHistory = TextEditingController();
  final TextEditingController place = TextEditingController();
  late DateTime? date = DateTime.now();
  final TextEditingController time = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  Future<void> addCriminal() async {
    String? server = dotenv.env['SERVER_URL'];
    String? url = "$server/criminal/add";
    final req = http.MultipartRequest('POST', Uri.parse(url));
    req.fields['name'] = name.text;
    req.fields['crimeHistory'] = crimeHistory.text;
    req.fields['place'] = place.text;
    req.fields['date'] = date.toString();
    req.fields['time'] = time.text;
    req.files.add(
      http.MultipartFile(
        'image',
        image!.readAsBytes().asStream(),
        image!.lengthSync(),
        filename: "image.jpg",
      ),
    );
    try {
      final res = await http.Response.fromStream(await req.send());
      if (res.statusCode == 200) {
        print(res.body);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
              controller: crimeHistory,
              label: "Crime History",
              text: "Enter Crime History",
            ),
            Input(
              controller: place,
              text: "Enter Place",
              label: "Place",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.firaSans(
                        fontSize: 18, color: TailwindColors.blueGray.shade600),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  DateSelectorWidget(
                    selectDate: selectDate,
                    date: date,
                  ),
                ],
              ),
            ),
            Input(
              controller: time,
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
                    onPressed: () => addCriminal(),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

class ImageToBlobConverter {
  static Future<Uint8List?> convertImageToBlob(String imagePath) async {
    // Load the image from file
    img.Image? image = img.decodeImage(await rootBundle
        .load(imagePath)
        .then((ByteData data) => data.buffer.asUint8List()));

    if (image != null) {
      // Encode the image as a Uint8List
      Uint8List blobData = img.encodePng(image);
      return blobData;
    } else {
      // Image decoding failed
      return null;
    }
  }
}
