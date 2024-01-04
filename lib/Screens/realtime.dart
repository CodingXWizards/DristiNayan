import "package:flutter/material.dart";

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
    return Center(
      child: ElevatedButton(
          onPressed: () {
            widget.toggleSecondBody();
          },
          child: const Text("Realtime")),
    );
  }
}
