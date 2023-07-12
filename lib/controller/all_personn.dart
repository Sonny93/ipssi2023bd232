import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/constante.dart';
import 'package:ipssi_bd23_2/controller/firestoreHelper.dart';
import 'package:ipssi_bd23_2/controller/user_card.dart';
import 'package:ipssi_bd23_2/controller/user_detail.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';

class AllPerson extends StatefulWidget {
  const AllPerson({Key? key}) : super(key: key);

  @override
  State<AllPerson> createState() => _AllPersonState();
}

class _AllPersonState extends State<AllPerson> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().cloudUsers.snapshots(),
        builder: (context, snap) {
          List? users = snap.data?.docs;

          if (users == []) {
            return const Text("Aucune Donnée");
          }

          return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                Utilisateur user = Utilisateur(users[index]);
                return UserDetailsPopup(
                    user: user,
                    childButton: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: UserCard(user: user),
                    ));
              });
        });
  }
}
