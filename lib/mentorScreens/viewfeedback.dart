// view the feedback
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFeedback extends StatefulWidget {
  ViewFeedback({Key? key}) : super(key: key);
  final String mentorUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  _ViewFeedbackState createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('feedback')
            .where('mentorUid', isEqualTo: widget.mentorUid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['feedback']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
