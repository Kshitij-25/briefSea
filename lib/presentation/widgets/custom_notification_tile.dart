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
      subtitle: Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
      trailing: Text('1m'),
    );
  }
}
