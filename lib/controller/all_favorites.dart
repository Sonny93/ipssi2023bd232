import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/constante.dart';
import 'package:ipssi_bd23_2/controller/user_card.dart';
import 'package:ipssi_bd23_2/controller/user_detail.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';

import 'firestoreHelper.dart';

class AllFavorites extends StatefulWidget {
  const AllFavorites({Key? key}) : super(key: key);

  @override
  State<AllFavorites> createState() => _AllFavoritesState();
}

class _AllFavoritesState extends State<AllFavorites> {
  List<String>? favorites = moi.favoris ?? List.empty();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().cloudUsers.snapshots(),
        builder: (context, snap) {
          List? favorites = moi.favoris;
          List? users = snap.data?.docs
              .where((u) => favorites?.contains(u.id) ?? false)
              .toList();

          if (users!.isEmpty || favorites!.isEmpty) {
            return const Text("Aucune Donnée");
          }

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Utilisateur user = Utilisateur(users[index]);
                return UserDetailsPopup(
                  user: user,
                  childButton: Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: UserCard(
                      user: user
                    ),
                  ),
                );
              });
        });
  }
}
