import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/constante.dart';
import 'package:ipssi_bd23_2/controller/firestoreHelper.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';

class UserCard extends StatefulWidget {
  Utilisateur user;

  UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(widget.user.avatar ?? defaultImage),
      ),
      title: Text(widget.user.fullName),
      subtitle: Text(
        widget.user.email,
        textAlign: TextAlign.start,
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() => setUserFavorite(widget.user));
        },
        icon: Icon(Icons.favorite,
            color: moi.isUserFavorite(widget.user) ? Colors.red : Colors.grey),
      ),
    );
  }
}

void setUserFavorite(Utilisateur user) {
  List<String> favorites = moi.favoris ?? List.empty();
  bool isFavorite = moi.isUserFavorite(user);

  if (isFavorite) {
    int index = favorites.indexOf(user.uid);
    favorites.removeAt(index);
  } else {
    favorites.add(user.uid);
  }

  moi.favoris = favorites;
  Map<String, dynamic> map = {"FAVORITES": favorites};
  FirestoreHelper().updateUser(moi.uid, map);
}
