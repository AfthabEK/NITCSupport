import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRequestListScreen extends StatefulWidget {
  @override
  _ChatRequestListScreenState createState() => _ChatRequestListScreenState();
}

String mentoremail = FirebaseAuth.instance.currentUser!.email.toString();
List<String> tags = [];

class _ChatRequestListScreenState extends State<ChatRequestListScreen> {
  List<ChatRequest> chatRequests = [];

  @override
  void initState() {
    super.initState();
    fetchMentorTags(mentoremail);
    fetchChatRequestsWithMatchingTags(tags);
  }

  // Fetch chat requests with matching tags from Firestore
  void fetchChatRequestsWithMatchingTags(
      List<String> mentorPreferredTags) async {
    // Replace with mentor's preferred tags
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('chatRequests').get();
      List<ChatRequest> matchingChatRequests = [];
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        List<String> chatTags =
            List.castFrom<dynamic, String>(data['tags'] ?? []);
        // Check if any of the chat tags match with mentor's preferred tags
        if (chatTags.any((tag) => mentorPreferredTags.contains(tag))) {
          ChatRequest chatRequest = ChatRequest.fromSnapshot(docSnapshot);
          matchingChatRequests.add(chatRequest);
        }
      }
      setState(() {
        chatRequests = matchingChatRequests;
      });
    } catch (e) {
      print('Error fetching chat requests with matching tags: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Requests'),
      ),
      body: ListView.builder(
        itemCount: chatRequests.length,
        itemBuilder: (context, index) {
          ChatRequest chatRequest = chatRequests[index];

          // Check if the chat request is accepted by the same mentor
          bool isAcceptedByMentor = chatRequest.acceptedby == mentoremail;

          return Column(
            children: [
              ListTile(
                title: Text('Title: ${chatRequest.title}'),
                subtitle: Text('Tags: ${chatRequest.tags.join(', ')}\n'
                    'Description: ${chatRequest.description}\n'
                    'Created At: ${chatRequest.createdAt.toString()}'),
                trailing: Text('acceptedby: ${chatRequest.acceptedby}'),
                // Set tile color to green if accepted by the same mentor
                tileColor: isAcceptedByMentor ? Colors.green : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: isAcceptedByMentor
                    ? [
                        ElevatedButton(
                          onPressed: () {
                            // Reject button callback
                          },
                          child: Text('Chat'),
                          //change backgroundcolor to green
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ]
                    : [
                        ElevatedButton(
                          onPressed: () {
                            // Accept button callback
                            _acceptChatRequest(context, chatRequest);
                          },
                          child: Text('Accept'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Reject button callback
                          },
                          child: Text('Reject'),
                        ),
                      ],
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

// ChatRequest class
class ChatRequest {
  String title; // User ID of the chat request
  String description; // Description of the chat request
  List<String> tags; // Tags associated with the chat request
  DateTime createdAt; // Time of chat request creation
  String user_id; // User ID of the chat request
  String acceptedby; // User ID of the mentor who accepted the chat request

  ChatRequest({
    required this.title,
    required this.description,
    required this.tags,
    required this.createdAt,
    required this.user_id,
    required this.acceptedby,
  });

  // Factory method to create a ChatRequest object from a Firestore DocumentSnapshot
  factory ChatRequest.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ChatRequest(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      tags: List.castFrom<dynamic, String>(data['tags'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      user_id: data['user_id'] ?? '',
      acceptedby: data['acceptedby'] ?? '',
    );
  }
}

Future<List<String>> fetchMentorTags(String mentorEmail) async {
  try {
    DocumentSnapshot mentorSnapshot = await FirebaseFirestore.instance
        .collection('mentors')
        .where('email', isEqualTo: mentorEmail)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);
    if (mentorSnapshot.exists) {
      Map<String, dynamic>? data =
          mentorSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        List<String> mentorTags =
            List.castFrom<dynamic, String>(data['tags'] ?? []);
        for (String tag in mentorTags) {
          tags.add(tag);
        }
        return mentorTags;
      }
    }

    return [];
  } catch (e) {
    print('Error fetching mentor tags: $e');
    return [];
  }
}

void _acceptChatRequest(BuildContext context, ChatRequest chatRequest) async {
  // Check mentor's availability
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('mentors')
      .where('email', isEqualTo: mentoremail)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    DocumentSnapshot mentorSnapshot = querySnapshot.docs.first;
    Map<String, dynamic>? mentorData =
        mentorSnapshot.data() as Map<String, dynamic>?;

    if (mentorData != null && mentorData['availability'] == true) {
      // Mentor is available, update mentor's availability to false
      await FirebaseFirestore.instance
          .collection('mentors')
          .doc(mentorSnapshot.id)
          .update({'availability': false});

      // Update chat request status to accepted

      QuerySnapshot chatRequestSnapshot = await FirebaseFirestore.instance
          .collection('chatRequests')
          .where('user_id', isEqualTo: chatRequest.user_id)
          .get();

      if (chatRequestSnapshot.docs.isNotEmpty) {
        DocumentSnapshot chatRequestDoc = chatRequestSnapshot.docs.first;
        Map<String, dynamic>? chatRequestData =
            chatRequestDoc.data() as Map<String, dynamic>?;

        if (chatRequestData != null) {
          if (chatRequestData['status'] != 'accepted') {
            // Update chat request status to accepted
            await FirebaseFirestore.instance
                .collection('chatRequests')
                .doc(chatRequestDoc.id)
                .update({'status': 'accepted'});

            await FirebaseFirestore.instance
                .collection('chatRequests')
                .doc(chatRequestDoc.id)
                .update({'acceptedby': mentoremail});
            // Show notification for successful acceptance
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Chat request accepted!'),
            ));
          } else {
            // Chat request status is already accepted, show error notification
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Chat request is already accepted.'),
            ));
          }
        } else {
          // Chat request data is null, show error notification
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Failed to accept chat request. Invalid chat request.'),
          ));
        }
      } else {
        // Chat request not found in the database, show error notification
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Failed to accept chat request. Chat request not found.'),
        ));
      }
    } else {
      // Mentor is not available, show notification for active chat session
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You already have an active chat session'),
      ));
    }
  } else {
    // Mentor not found in the database, show error notification
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to accept chat request. Mentor not found.'),
    ));
  }
}