import "dart:convert";
import "dart:typed_data";

import "package:dristi_nayan/Models/Criminal.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_tailwindcss_defaults/colors.dart";
import "package:google_fonts/google_fonts.dart";
import "package:http/http.dart" as http;

class TrackCriminal extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const TrackCriminal({super.key, required this.toggleSecondBody});

  @override
  State<TrackCriminal> createState() => _TrackCriminal();
}

class _TrackCriminal extends State<TrackCriminal> {
  List<Criminal> criminals = [];
  bool isLoading = true;

  Future<void> getCriminals() async {
    String? server = dotenv.env['SERVER_URL'];
    String? url = "$server/criminal";

    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        List<dynamic> jsonData = json.decode(res.body);
        setState(() {
          criminals = jsonData.map((data) => Criminal.fromJson(data)).toList();

          isLoading = false;
        });
      }
    } catch (err) {
      isLoading = false;
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    getCriminals();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                "Criminal Record Panel",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                    fontSize: 20, color: TailwindColors.blueGray.shade600),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              // border: Border.all(color: TailwindColors.blueGray),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    color: TailwindColors.blueGray.shade200)
              ],
              color: TailwindColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade700),
                ),
                Text(
                  "Crime History",
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade700),
                ),
                Text(
                  "Record",
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade700),
                ),
                Text(
                  "Photo",
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            // Wrap ListView.builder with Expanded
            child: !isLoading
                ? ListView.builder(
                    itemCount: criminals.length,
                    itemBuilder: (context, index) => RecordPanel(
                      name: criminals[index].name,
                      crimeHist: criminals[index].crimeHistory,
                      record: {
                        "detected": criminals[index].place,
                        "date": criminals[index].date,
                        "time": criminals[index].time,
                      },
                      photo: criminals[index].image,
                    ),
                  )
                : const Text("Loading"),
          ),
        ],
      ),
    );
  }
}

class RecordPanel extends StatelessWidget {
  final String? name;
  final String? crimeHist;
  final Map<String, dynamic> record;
  final Uint8List? photo;
  const RecordPanel({
    super.key,
    required this.name,
    required this.crimeHist,
    required this.record,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    print(photo);
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          // border: Border.all(color: TailwindColors.blueGray),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 2,
                color: TailwindColors.blueGray.shade200)
          ],
          color: TailwindColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name!,
              style:
                  GoogleFonts.firaSans(color: TailwindColors.blueGray.shade600),
            ),
            Text(
              crimeHist!,
              style:
                  GoogleFonts.firaSans(color: TailwindColors.blueGray.shade600),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record["detected"],
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade600, fontSize: 12),
                ),
                Text(
                  record["date"],
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade600, fontSize: 12),
                ),
                Text(
                  record["time"],
                  style: GoogleFonts.firaSans(
                      color: TailwindColors.blueGray.shade600, fontSize: 12),
                ),
              ],
            ),
            Image.memory(photo!, fit: BoxFit.contain, height: 10, width: 10,),
          ],
        ),
      ),
    );
  }
}
