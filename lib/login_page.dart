import 'question_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'models/question_model.dart';
import 'widgets/question_widget.dart';
import 'widgets/next_button.dart';
import 'widgets/options.dart';
import 'widgets/result.dart';
import 'question_pages.dart';
import 'login_mentor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 163, 221),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to NITCSupport",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 211, 194, 194)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: Text("Login",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MentorLoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Login as mentor",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginSGC(),
                            ),
                          );
                        },
                        child: Text(
                          "SGC Login",
                          style: TextStyle(color: Colors.black),
                        ))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
