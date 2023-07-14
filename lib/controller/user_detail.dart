import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/user_card.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';
import 'package:ipssi_bd23_2/view/background_view.dart';

import '../view/messagerie_view.dart';
import 'constante.dart';

class UserDetailsPopup extends StatefulWidget {
  Widget childButton;
  Utilisateur user;

  UserDetailsPopup({Key? key, required this.childButton, required this.user})
      : super(key: key);

  @override
  State<UserDetailsPopup> createState() => _UserDetailsPopupState();
}

class _UserDetailsPopupState extends State<UserDetailsPopup> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    content: Container(
                      color: Colors.amber,
                      child: Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          const BackgroundView(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    widget.user.avatar ?? defaultImage),
                              ),
                              const SizedBox(height: 25),
                              Text(
                                  '${widget.user.prenom.capitalize()} ${widget.user.nom.toUpperCase()}',
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start),
                              const SizedBox(height: 25),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start),
                                    Text(widget.user.email)
                                  ]),
                              const SizedBox(height: 25),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Téléphone',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start),
                                    Text(widget.user.telephone != ''
                                        ? widget.user.telephone.toString()
                                        : 'Aucun')
                                  ]),
                              const SizedBox(height: 25),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Pseudonyme',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start),
                                    Text(widget.user.pseudo != ''
                                        ? widget.user.pseudo.toString()
                                        : 'Aucun')
                                  ]),
                            ],
                          )
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton.icon(
                          icon: const Icon(Icons.messenger),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MessagerieView(autrePersonne: widget.user);
                            }));
                          },
                          label: Text("Message")),
                      TextButton(
                          onPressed: () =>
                              setState(() => setUserFavorite(widget.user)),
                          child: Text(moi.isUserFavorite(widget.user)
                              ? 'Retirer favoris'
                              : 'Ajouter favoris')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("C'est ok!!")),
                    ],
                  );
                });
              });
        },
        child: widget.childButton);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
