import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/model/message.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';

import 'constante.dart';
import 'firestoreHelper.dart';

class ListMessages extends StatefulWidget {
  List<Utilisateur> users;
  ScrollController scrollController;

  ListMessages({Key? key, required this.users, required this.scrollController})
      : super(key: key);

  @override
  State<ListMessages> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().cloudMessages.orderBy('DATE').snapshots(),
        builder: (context, snap) {
          if (snap.data?.docs == null || snap.data!.docs.isEmpty) {
            return const Text("Aucun message");
          }

          List messages = snap.data!.docs
              .map((element) => Message(element))
              .where((message) =>
                  widget.users.map((u) => u.uid).contains(message.expediteur) &&
                  widget.users.map((u) => u.uid).contains(message.destinataire))
              .toList();

          return ListView.builder(
              controller: widget.scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message message = messages[index];
                bool isMoi = moi.uid == message.expediteur;

                return Container(
                  decoration: BoxDecoration(
                    color: isMoi ? Colors.green : Colors.blue[800],
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isMoi
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.date.toDate().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        message.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
