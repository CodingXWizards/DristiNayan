import 'dart:async';

import 'package:dristi_nayan/Screens/home.dart';
import 'package:dristi_nayan/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? authToken = sp.getString('authToken');
    bool isLogin = authToken != null ? true : false;
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => isLogin ? const Home() : const Login(),
            settings: RouteSettings(name: isLogin ? '/home' : '/login')
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                width: size.width * 0.6,
                image: const AssetImage("assets/images/Logo.webp"),
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Dristi Nayan",
              style: GoogleFonts.viga(fontSize: 28, color: TailwindColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
