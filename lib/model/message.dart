import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String uid;
  late DateTime date;
  late String expediteur;
  late String destinataire;
  late String message;

  Message.vide() {
    uid = "";
    date = DateTime.now();
    expediteur = "";
    destinataire = "";
    message = "";
  }

  Message(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    date = map["DATE"];
    expediteur = map["EXPEDITEUR"];
    destinataire = map["DESTINATAIRE"];
    message = map["MESSAGE"];
  }
}
