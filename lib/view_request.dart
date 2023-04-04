import 'package:flutter/material.dart';
import 'request_item.dart';
import 'mentor_dashboard.dart';
import 'view_feedback.dart';

class ViewRequest extends StatelessWidget {
  const ViewRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "View Chat Request",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MentorDashboard(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  RequestItem(),
                  RequestItem(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "View Chat Request",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MentorDashboard(),
            ),
          );
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 30,
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
*/