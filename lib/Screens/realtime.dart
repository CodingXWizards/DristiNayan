import "package:flutter/material.dart";
import "package:flutter_tailwindcss_defaults/colors.dart";
import "package:google_fonts/google_fonts.dart";

class Realtime extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const Realtime({
    super.key,
    required this.toggleSecondBody,
  });

  @override
  State<Realtime> createState() => _Realtime();
}

class _Realtime extends State<Realtime> {
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
                  "Real-Time Crowd Monitoring",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: TailwindColors.blueGray.shade600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) => CameraBox(index: index+1,)),
              ),
            ),
            // const CameraBox(),
          ],
        ),
      ),
    );
  }
}

class CameraBox extends StatelessWidget {
  final int index;
  const CameraBox({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: size.width * 0.4,
      height: size.width * 0.4 + 20,
      child: Column(
        children: [
          Text(
            "Camera $index",
            style: GoogleFonts.firaSans(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            width: size.width * 0.4,
            height: size.width * 0.4 - 20,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: TailwindColors.blueGray.shade300,
              boxShadow: [
                BoxShadow(
                    blurRadius: 12,
                    spreadRadius: 2,
                    color: TailwindColors.blueGray.shade200)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
