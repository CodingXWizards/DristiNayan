import 'package:dristi_nayan/Screens/edit_criminal.dart';
import 'package:dristi_nayan/Screens/realtime.dart';
import 'package:dristi_nayan/Screens/track_criminal.dart';
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
  bool showSecondBody = false;
  String screenName = "editCriminal";

  void toggleSecondBody() {
    setState(() {
      showSecondBody = !showSecondBody;
    });
  }

  void chooseScreen(String name) {
    setState(() {
      screenName = name;
    });
  }

  List homeTileInfo = [
    {
      "title": "Real-Time Crowd Monitoring",
      "desc":
          "Real-time crowd monitoring instantly tracks and manages people's movements in a specific area.",
      "button": "View Now",
      "image": "realtime.svg",
      "screenName": "realtime",
    },
    {
      "title": "Track Criminals & Crime",
      "desc":
          "CCTV integration enhances security by consolidating surveillance data, enabling comprehensive monitoring, and facilitating efficient incident response.",
      "button": "View Now",
      "image": "track.svg",
      "screenName": "track_criminal",
    },
    {
      "title": "Add/Edit Criminal Detail",
      "desc":
          "GPS tracking for emergency response enables precise location identification, facilitating swift and accurate deployment of resources during critical situations.",
      "button": "Edit Now",
      "image": "crime.svg",
      "screenName": "edit_criminal",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        top: 0,
        bottom: 0,
        left: showSecondBody ? -width : 0,
        right: showSecondBody ? width : 0,
        curve: Curves.easeInOut,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: homeTileInfo.length,
          itemBuilder: (context, index) {
            return HomeTile(
              title: homeTileInfo[index]["title"],
              desc: homeTileInfo[index]["desc"],
              button: homeTileInfo[index]["button"],
              image: homeTileInfo[index]["image"],
              screenName: homeTileInfo[index]["screenName"],
              showSecondBody: showSecondBody,
              toggleSecondBody: toggleSecondBody,
              chooseScreen: chooseScreen,
            );
          },
        ),
      ),
      screenName == "realtime"
          ? AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 0,
              bottom: 0,
              left: showSecondBody ? 0 : width,
              right: showSecondBody ? 0 : -width,
              curve: Curves.easeInOut,
              child: Realtime(
                toggleSecondBody: toggleSecondBody,
              ),
            )
          : (screenName == "track_criminal"
              ? AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: 0,
                  bottom: 0,
                  left: showSecondBody ? 0 : width,
                  right: showSecondBody ? 0 : -width,
                  curve: Curves.easeInOut,
                  child: TrackCriminal(
                    toggleSecondBody: toggleSecondBody,
                  ),
                )
              : AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: 0,
                  bottom: 0,
                  left: showSecondBody ? 0 : width,
                  right: showSecondBody ? 0 : -width,
                  curve: Curves.easeInOut,
                  child: EditCriminal(
                    toggleSecondBody: toggleSecondBody,
                  ),
                ))
    ]);
  }
}

class HomeTile extends StatelessWidget {
  final String title;
  final String desc;
  final String button;
  final String image;
  final String screenName;
  final bool showSecondBody;
  final VoidCallback toggleSecondBody;
  final Function(String) chooseScreen;

  const HomeTile({
    super.key,
    required this.title,
    required this.desc,
    required this.button,
    required this.image,
    required this.screenName,
    required this.showSecondBody,
    required this.toggleSecondBody,
    required this.chooseScreen,
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
                          onPressed: () {
                            toggleSecondBody();
                            chooseScreen(screenName);
                          },
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
