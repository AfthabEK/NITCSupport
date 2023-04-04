import 'user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    var _value1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Q) Where is CZ located in NITC?",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Inside OAT",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Near basketball court",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Above Auditorium",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "None of the above",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePages(),
                      ),
                    );
                  },
                  child: Text(
                    "Next",
                    style: GoogleFonts.plusJakartaSans(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
