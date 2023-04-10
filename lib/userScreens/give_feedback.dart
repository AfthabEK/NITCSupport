import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';

class GiveFeedback extends StatefulWidget {
  const GiveFeedback({super.key});

  @override
  State<GiveFeedback> createState() => _GiveFeedbackState();
}

class _GiveFeedbackState extends State<GiveFeedback> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [
    Question(
      isMandatory: true,
      question: 'Do you feel better after this session?',
      answerChoices: {
        "Yes": null,
        "No": [
          Question(
            question: "Please tell us what went wrong",
          )
        ],
      },
    ),
    Question(
        question: "Were you able to find a solution to your problem?",
        isMandatory: true,
        answerChoices: const {
          "Yes": null,
          "No": null,
        }),
    Question(
        question: "How would you rate this mentor on a scale of 1 to 5?",
        isMandatory: true,
        answerChoices: const {
          "1": null,
          "2": null,
          "3": null,
          "4": null,
          "5": null,
        }),
    Question(
      question: "Do you have anything to suggest to the mentor?",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Survey(
            onNext: (questionResults) {
              _questionResults = questionResults;
            },
            initialData: _initialData),
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: SizedBox(
            width: 100,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue, // Background Color
                shape: StadiumBorder(),
              ),
              child: const Text("Submit"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //do something
                }
              },
            ),
          )),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: SizedBox(
            width: 100,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue, // Background Color
                shape: StadiumBorder(),
              ),
              child: const Text("Skip Feedback"),
              onPressed: () {},
            ),
          )),
        ],
      ),
    );
  }
}
