import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/messageController.dart';

import '../model/message.dart';

class ListMessages extends StatefulWidget {
  List<String> users;

  ListMessages({Key? key, required this.users}) : super(key: key);

  @override
  State<ListMessages> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  List<Message> messages =[];

  @override
  void initState() {
    // TODO: implement initState
    MessageController().getDirectMessages(widget.users).then((value) {
      setState(() {
        messages = value;
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          Message message = messages[index];
          return Card(
            elevation: 10,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Text(message.message),
          );
        });
  }
}
