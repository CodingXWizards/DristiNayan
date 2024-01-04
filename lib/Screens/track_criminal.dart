import "package:flutter/material.dart";

class TrackCriminal extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const TrackCriminal({super.key, required this.toggleSecondBody});

  @override
  State<TrackCriminal> createState() => _TrackCriminal();
}

class _TrackCriminal extends State<TrackCriminal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            widget.toggleSecondBody();
          },
          child: const Text("Track Criminal")),
    );
  }
}
