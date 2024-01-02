import 'dart:convert';

import 'package:dristi_nayan/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountDestination extends StatefulWidget {
  const AccountDestination({super.key});

  @override
  State<AccountDestination> createState() => _AccountDestinationState();
}

class _AccountDestinationState extends State<AccountDestination> {
  User user = User();
  String name = "";

  void clearSP() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userID = sp.getString('userId');
    String url = "http://localhost:5000/auth/user?userID=$userID";
    try {
      final res = await http.get(Uri.parse(url));
      user = User.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
      if (user.name?.isNotEmpty == true) {
        setState(() => name = "${user.name}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Account",
            textAlign: TextAlign.center,
            style: GoogleFonts.firaSans(
                fontSize: 32, color: TailwindColors.blueGray.shade600),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            leading: const Icon(
              Icons.account_circle,
              color: TailwindColors.blueGray,
              size: 50,
            ),
            title: Text(
              name,
              style: GoogleFonts.firaSans(fontSize: 20),
            ),
            subtitle: Text(
              "Railway Official",
              style: GoogleFonts.firaSans(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Column(
            children: [
              SettingButtons(
                title: "Account",
                iconName: Icons.settings,
              ),
              SettingButtons(
                title: "Security",
                iconName: Icons.security,
              ),
              SettingButtons(
                title: "Privacy Policy",
                iconName: Icons.privacy_tip,
              ),
              SettingButtons(
                title: "Help Centre",
                iconName: Icons.help,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                clearSP();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: TailwindColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50)),
              child: Text(
                "Sign Out",
                style: GoogleFonts.firaSans(fontSize: 20, color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  final String title;
  final IconData iconName;
  const SettingButtons(
      {super.key, required this.title, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: TailwindColors.blueGray.shade400),
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(
          iconName,
          size: 30,
          color: TailwindColors.blueGray,
        ),
        title: Text(
          title,
          style: GoogleFonts.firaSans(fontSize: 18),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: TailwindColors.blueGray,
        ),
      ),
    );
  }
}
