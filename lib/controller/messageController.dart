import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';

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

  Future<List<Message>> getDirectMessages(List<String> users) async{
    List<Message> messages = [];
    Stream<QuerySnapshot> streamer =
        cloudMessages.orderBy('DATE', descending: false).snapshots();
    print("ftvtctfct");
   /* streamer.toList().then((value) {
      print(value.runtimeType);
    print("ftvtctfct 2");
      messages = value
          .map((element) => element as Message)
          .where((element) =>
              element.destinataire == users[0] ||
              element.expediteur == users[0] ||
              element.destinataire == users[1] ||
              element.expediteur == users[1])
          .toList();
    });*/
    print("object");
    List<QuerySnapshot> snapshots = await streamer.toList();
print(snapshots);
    messages = snapshots
        .expand((snapshot) => snapshot.docs.map((doc) => doc.data() as Message))
        .where((message) =>
    message.destinataire == users[0] ||
        message.expediteur == users[0] ||
        message.destinataire == users[1] ||
        message.expediteur == users[1])
        .toList();

    print("object");

    return messages;
  }
}
