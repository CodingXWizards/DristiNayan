import "package:flutter/material.dart";
import "package:flutter_tailwindcss_defaults/colors.dart";
import "package:google_fonts/google_fonts.dart";

class TrackCriminal extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const TrackCriminal({super.key, required this.toggleSecondBody});

  @override
  State<TrackCriminal> createState() => _TrackCriminal();
}

class _TrackCriminal extends State<TrackCriminal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Expanded(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.firaSans(),
                  ),
                  Text(
                    "Crime History",
                    style: GoogleFonts.firaSans(),
                  ),
                  Text(
                    "Record",
                    style: GoogleFonts.firaSans(),
                  ),
                  Text(
                    "Photo",
                    style: GoogleFonts.firaSans(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const RecordPanel(
              name: "Raja Singh",
              crimeHist: "I.P.C. 420",
              record: {
                "detected": "Raipur",
                "date": "25/12/23",
                "time": "1:30 PM"
              },
              photo: "Photo",
            ),
            const RecordPanel(
              name: "Raja Singh",
              crimeHist: "I.P.C. 420",
              record: {
                "detected": "Raipur",
                "date": "25/12/23",
                "time": "1:30 PM"
              },
              photo: "Photo",
            ),
            const RecordPanel(
              name: "Raja Singh",
              crimeHist: "I.P.C. 420",
              record: {
                "detected": "Raipur",
                "date": "25/12/23",
                "time": "1:30 PM"
              },
              photo: "Photo",
            ),
            const RecordPanel(
              name: "Raja Singh",
              crimeHist: "I.P.C. 420",
              record: {
                "detected": "Raipur",
                "date": "25/12/23",
                "time": "1:30 PM"
              },
              photo: "Photo",
            ),
          ],
        ),
      ),
    );
  }
}

class RecordPanel extends StatelessWidget {
  final String name;
  final String crimeHist;
  final Map<String, dynamic> record;
  final String photo;
  const RecordPanel({
    super.key,
    required this.name,
    required this.crimeHist,
    required this.record,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: TailwindColors.blueGray)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: GoogleFonts.firaSans(color: TailwindColors.blueGray),
          ),
          Text(
            crimeHist,
            style: GoogleFonts.firaSans(color: TailwindColors.blueGray),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record["detected"],
                style: GoogleFonts.firaSans(
                    color: TailwindColors.blueGray, fontSize: 12),
              ),
              Text(
                record["date"],
                style: GoogleFonts.firaSans(
                    color: TailwindColors.blueGray, fontSize: 12),
              ),
              Text(
                record["time"],
                style: GoogleFonts.firaSans(
                    color: TailwindColors.blueGray, fontSize: 12),
              ),
            ],
          ),
          Text(
            "Photo",
            style: GoogleFonts.firaSans(color: TailwindColors.blueGray),
          ),
        ],
      ),
    );
  }
}
