import 'package:cloud_firestore/cloud_firestore.dart';

class MessageController {
  final cloudMessages = FirebaseFirestore.instance.collection("MESSAGESS&T");

  void save(String message, String expediteurUid, String destinataireUid) {
    final messageData = <String, dynamic>{
      "DATE": DateTime.now(),
      "MESSAGE": message,
      "DESTINATAIRE": destinataireUid,
      "EXPEDITEUR": expediteurUid,
    };

    cloudMessages
        .doc()
        .set(messageData)
        .onError((e, _) => print("Error writing document: $e"));
  }
}