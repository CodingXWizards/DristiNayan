import "package:flutter/material.dart";

class EditCriminal extends StatefulWidget {
  final VoidCallback toggleSecondBody;
  const EditCriminal({super.key, required this.toggleSecondBody});

  @override
  State<EditCriminal> createState() => _EditCriminal();
}

class _EditCriminal extends State<EditCriminal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            widget.toggleSecondBody();
          },
          child: const Text("Edit Criminal")),
    );
  }
}
