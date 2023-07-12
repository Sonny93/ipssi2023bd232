import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MessageController {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");
  final cloudMessages = FirebaseFirestore.instance.collection("MESSAGESS&T");

  void save(String message, String expediteurUid, String destinataireUid) {
    final messageData = <String,dynamic>{
      "DATE": DateTime.now(),
      "MESSAGE": message,
      "DESTINATAIRE": destinataireUid,
      "EXPEDITEUR": expediteurUid,
    };

    cloudMessages.doc("$expediteurUid-$destinataireUid").set(messageData).onError((e, _) => print("Error writing document: $e"));
  }


}