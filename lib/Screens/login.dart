import 'dart:convert';
import 'package:dristi_nayan/Models/User.dart';
import 'package:dristi_nayan/Screens/Components/input.dart';
import 'package:dristi_nayan/Screens/home.dart';
import 'package:dristi_nayan/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  String info = "";
  bool isLoading = false;

  Future<int> login(userId, password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    const String url = "http://localhost:5000/auth/login";
    try {
      final res = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, dynamic>{'userId': userId, 'password': password}));
      if (res.statusCode == 200) {
        AuthToken? user =
            AuthToken.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
        String? authToken = user.authToken;
        String? userId = user.user?.userID;
        if (authToken != null && userId != null) {
          sp.setString('authToken', authToken);
          sp.setString('userId', userId);
        }
      }
      return res.statusCode;
    } catch (error) {
      info = "error";
      isLoading = false;
      return 500;
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
                        "Login with Account",
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
                        height: 20,
                      ),
                      Text(
                        info,
                        style: GoogleFonts.firaSans(
                            color: TailwindColors.red, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (userIdController.text.length < 3) {
                            setState(() => info =
                                "UserID should more be more than 3 letters");
                            return;
                          } else if (passwordController.text.length < 5) {
                            setState(() => info =
                                "Password should be more than 5 letters");
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          // setState(() {
                          login(userIdController.text, passwordController.text)
                              .then((value) {
                            switch (value) {
                              case 200:
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home(),
                                        settings:
                                            const RouteSettings(name: '/')));
                                break;
                              case 404:
                                info = "UserID is incorrect!";
                                break;
                              case 400:
                                info = "Password is incorrect";
                                break;
                              case 500:
                                info = "Internal Server Error";
                                break;
                              default:
                                info = "An unexpected error occured!";
                            }
                            setState(() => isLoading = false);
                          });
                          // });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          isLoading ? "Loading..." : "Login",
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
                            "Don't have an Account?",
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
                                      builder: (context) => const Signup(),
                                      settings: const RouteSettings(
                                          name: '/signup')));
                            },
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.firaSans(
                                fontSize: 18,
                                color: TailwindColors.blue,
                              ),
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
