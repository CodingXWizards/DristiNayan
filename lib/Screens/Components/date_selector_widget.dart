import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DateSelectorWidget extends StatefulWidget {
  final Function(BuildContext) selectDate;
  final DateTime? date;

  DateSelectorWidget({super.key, required this.selectDate, required this.date});
  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: widget.date ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != widget.date) {
  //     setState(() {
  //       widget.date = picked;
  //       print(widget.date);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectDate(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: TailwindColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: TailwindColors.blueGray),
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                spreadRadius: 2,
                color: TailwindColors.blueGray.shade100)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.date != null
                  ? "${widget.date?.toLocal()}".split(' ')[0]
                  : 'Select Date',
              style: GoogleFonts.firaSans(fontSize: 16),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
