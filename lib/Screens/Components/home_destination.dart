import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDestination extends StatefulWidget {
  const HomeDestination({super.key});

  @override
  State<HomeDestination> createState() => _HomeDestinationState();
}

class _HomeDestinationState extends State<HomeDestination>
    with TickerProviderStateMixin {
  late final TabController _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeTile(
              title: "Real-Time Crowd Monitoring",
              desc:
                  "Real-time crowd monitoring instantly tracks and manages people's movements in a specific area.",
              button: "View Now",
              image: "realtime.svg",
            ),
            SizedBox(height: 12,),
            HomeTile(
              title: "Track Criminals & Crime",
              desc:
                  "CCTV integration enhances security by consolidating surveillance data, enabling comprehensive monitoring, and facilitating efficient incident response.",
              button: "View Now",
              image: "track.svg",
            ),
            SizedBox(height: 12,),
            HomeTile(
              title: "Add/Edit Criminal Detail",
              desc:
                  "GPS tracking for emergency response enables precise location identification, facilitating swift and accurate deployment of resources during critical situations.",
              button: "Edit Now",
              image: "crime.svg",
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTile extends StatelessWidget {
  final String title;
  final String desc;
  final String button;
  final String image;
  const HomeTile(
      {super.key,
      required this.title,
      required this.desc,
      required this.button,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: TailwindColors.white,
          boxShadow: [
            BoxShadow(
                color: TailwindColors.blueGray.shade300,
                blurRadius: 12,
                spreadRadius: 2)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: TailwindColors.blueGray.shade600,
                      fontWeight: FontWeight.w600),
                ),
                Flexible(
                  child: Text(
                    desc,
                    style: GoogleFonts.raleway(color: TailwindColors.blueGray),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TailwindColors.blue),
                  child: Text(
                    button,
                    style: GoogleFonts.firaSans(color: TailwindColors.white),
                  ),
                )
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/images/$image',
            width: 120,
          )
        ],
      ),
    );
  }
}
