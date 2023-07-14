import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipssi_bd23_2/controller/list_messages.dart';
import 'package:ipssi_bd23_2/controller/messageController.dart';
import 'package:ipssi_bd23_2/model/utilisateur.dart';
import 'package:ipssi_bd23_2/view/background_view.dart';

import '../controller/constante.dart';

class MessagerieView extends StatefulWidget {
  Utilisateur autrePersonne;

  MessagerieView({Key? key, required this.autrePersonne}) : super(key: key);

  @override
  State<MessagerieView> createState() => _MessagerieViewState();
}

class _MessagerieViewState extends State<MessagerieView> {
  //variable
  TextEditingController messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void _scrollDown() =>
      _controller.jumpTo(_controller.position.maxScrollExtent);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 500), _scrollDown);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.autrePersonne.fullName),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundView(),
          bodyPage(),
        ],
      ),
    );
  }

  Widget bodyPage() {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            //message qui va être affiché
            Flexible(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListMessages(
                  users: [moi, widget.autrePersonne],
                  scrollController: _controller),
            )),
            const Divider(
              height: 1.5,
            ),
            //message qu'on  tape
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Entrer votre message"),
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (messageController.text != "") {
                          String message = messageController.text;
                          String authUid = moi.uid;
                          String receiverUid = widget.autrePersonne.uid;
                          MessageController()
                              .save(message, authUid, receiverUid);
                          setState(() {
                            messageController.text = "";
                          });
                        }
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
