import 'dart:convert';
import 'package:dristi_nayan/Screens/Components/input.dart';
import 'package:dristi_nayan/Screens/home.dart';
import 'package:dristi_nayan/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signup(name, userId, password) async {
    const String url = 'http://localhost:5000/auth/signup';
    try {
      final res = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'name': name,
            'userId': userId,
            'password': password
          }));
      if (res.statusCode == 200) {
        print(res.body);
      } else {
        print(res.body);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Dristi Nayan",
              style: GoogleFonts.viga(
                fontSize: 36,
                color: TailwindColors.blue,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "An Crime Management Application",
              style: GoogleFonts.firaSans(
                fontSize: 18,
                color: TailwindColors.coolGray.shade600,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: TailwindColors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Create Account with UserID",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                          color: TailwindColors.blueGray,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Input(
                        controller: nameController,
                        hintText: "Name",
                        keyboard: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(
                        controller: userIdController,
                        hintText: "UserID",
                        keyboard: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Input(
                          controller: passwordController,
                          hintText: "Password",
                          keyboard: TextInputType.text,
                          isPassword: true),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signup(nameController.text, userIdController.text,
                              passwordController.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home(),
                                  settings: const RouteSettings(name: '/')
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          "Sign up with UserID",
                          style: GoogleFonts.firaSans(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: GoogleFonts.firaSans(
                                fontSize: 18, color: TailwindColors.blueGray),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login(),
                                      settings: const RouteSettings(name: '/login')
                                      ));
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.firaSans(
                                  fontSize: 18, color: TailwindColors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
