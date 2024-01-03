import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDestination extends StatefulWidget {
  const HomeDestination({super.key});

  @override
  State<HomeDestination> createState() => _HomeDestinationState();
}

class _HomeDestinationState extends State<HomeDestination> {
  List homeTileInfo = [
    {
      "title": "Real-Time Crowd Monitoring",
      "desc":
          "Real-time crowd monitoring instantly tracks and manages people's movements in a specific area.",
      "button": "View Now",
      "image": "realtime.svg",
      "routePath": "realtime",
      "screenName": "realtime",
    },
    {
      "title": "Track Criminals & Crime",
      "desc":
          "CCTV integration enhances security by consolidating surveillance data, enabling comprehensive monitoring, and facilitating efficient incident response.",
      "button": "View Now",
      "image": "track.svg",
      "routePath": "trackCriminal",
      "screenName": "track_criminal",
    },
    {
      "title": "Add/Edit Criminal Detail",
      "desc":
          "GPS tracking for emergency response enables precise location identification, facilitating swift and accurate deployment of resources during critical situations.",
      "button": "Edit Now",
      "image": "crime.svg",
      "route": "editCriminal",
      "screenName": "edit_criminal",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homeTileInfo.length,
      itemBuilder: (context, index) {
        return HomeTile(
            title: homeTileInfo[index]["title"],
            desc: homeTileInfo[index]["desc"],
            button: homeTileInfo[index]["button"],
            image: homeTileInfo[index]["image"],
            route: homeTileInfo[index]["route"],
            screenName: homeTileInfo[index]["screenName"]
            );
      },
    );
  }
}

class HomeTile extends StatelessWidget {
  final String title;
  final String desc;
  final String button;
  final String image;
  final String route;
  final String screenName;
  const HomeTile(
      {super.key,
      required this.title,
      required this.desc,
      required this.button,
      required this.image,
      required this.route,
      required this.screenName,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
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
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.raleway(
                  fontSize: 20,
                  color: TailwindColors.blueGray.shade600,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            desc,
                            style: GoogleFonts.raleway(
                                color: TailwindColors.blueGray, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              backgroundColor: TailwindColors.blue),
                          child: Text(
                            button,
                            style: GoogleFonts.firaSans(
                                color: TailwindColors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset(
                    'assets/images/$image',
                    width: 100,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
