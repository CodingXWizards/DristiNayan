import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsDestination extends StatefulWidget {
  const NotificationsDestination({super.key});

  @override
  State<NotificationsDestination> createState() =>
      _NotificationsDestinationState();
}

class _NotificationsDestinationState extends State<NotificationsDestination> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Notifications",
              style: GoogleFonts.firaSans(
                  fontSize: 28, color: TailwindColors.blueGray.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const NotificationTile(
              text:
                  "Scheduled power outage affecting Station A this Sunday from 1 AM to 5 AM. Please plan your operations accordingly",
            ),
            const NotificationTile(
              text:
                  "Suspicious activity reported near the cargo area. Kindly remain vigilant and report any unusual incidents to the authorities",
            ),
            const NotificationTile(
              text:
                  "Severe thunderstorms expected in the region. Take necessary precautions and ensure passenger safety during boarding and disembarking",
            ),
            const NotificationTile(
              text:
                  "Ensure all safety protocols are followed during maintenance checks on the tracks. Your adherence is crucial for a secure operation",
            ),
            const NotificationTile(
              text:
                  "Expect increased footfall during the weekend festival. Coordinate with security for efficient crowd management and safety measures",
            ),
            const NotificationTile(
              text:
                  "New feature 'Incident Report' now available on the app. Easily report any issues or emergencies for swift resolution",
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String text;
  const NotificationTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              blurRadius: 12,
              spreadRadius: 2,
              color: TailwindColors.blueGray.shade300)
        ],
      ),
      child: Row(children: [
        Icon(
          Icons.notifications,
          color: TailwindColors.blueGray.shade600,
          size: 32,
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.firaSans(color: TailwindColors.blueGray),
          ),
        )
      ]),
    );
  }
}
