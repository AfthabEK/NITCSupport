import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nitcsupport/form.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
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
                "Welcome",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MyForm(),
                    ),
                  );
                },
                label: Text("Create Chat Request",
                    style: TextStyle(color: Colors.black)),
                icon: Icon(Icons.add),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text("View chat request",
                          style: TextStyle(color: Colors.black))),
                  TextButton(
                      onPressed: () {},
                      child: Text("View self-help content",
                          style: TextStyle(color: Colors.black)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
