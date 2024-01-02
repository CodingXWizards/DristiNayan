import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  List<Map<String, dynamic>> items = [
    {
      "name": "Home",
    },
    {
      "name": "Live Camera",
    },
    {
      "name": "About Us",
    },
    {
      "name": "Logout",
    },
  ];

  void clearSP()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if(items[index]['name'] == 'Logout'){
              clearSP();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              items[index]['name'],
              style: GoogleFonts.firaSans(
                color: TailwindColors.blueGray.shade700,
                fontSize: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}
