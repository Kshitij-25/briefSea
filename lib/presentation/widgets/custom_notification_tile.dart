import 'package:flutter/material.dart';

class CustomNotificationTile extends StatelessWidget {
  const CustomNotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFF1B0C6B),
      ),
      title: Text(
        "data",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
      trailing: Text('1m'),
    );
  }
}
