import 'package:flutter/material.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Color(0xD9DAFFF0),
        leading: Icon(
          Icons.account_circle_sharp,
          color: Colors.deepPurple,
          size: 50,
        ),
        title: Text(
          "Title of chat request",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description of chat request",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "",
              style: TextStyle(
                fontSize: 8,
              ),
            ),
            Row(
              children: [
                Text(
                  "Tag1",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    backgroundColor: Colors.blue,
                    color: Colors.white,
                  ),
                ),
                Text("\t"),
                Text(
                  "Tag2",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    backgroundColor: Colors.blue,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              "",
              style: TextStyle(
                fontSize: 8,
              ),
            ),
            Text(
              "HH:MM:SS",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_box_rounded,
                color: Colors.green,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.disabled_by_default_rounded,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
