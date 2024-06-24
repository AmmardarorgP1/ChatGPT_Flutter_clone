// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import '../models/ChatModel.dart';
import '../models/Model.dart';
import '../models/Network.dart';
import '../provider/Provider.dart';
import '../widgets/Chat_Widget.dart';
import '../consts/consts.dart';
import '../services/Asset_manager.dart';
import '../widgets/Drop_Down_Button.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController textEditingController = TextEditingController();
  bool _isTyping = false;
   late ChatModel messagesReplied;
  List<ChatModel> listMessages = [];
  FocusNode focusNode = FocusNode();
  final ScrollController _listScrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController;
    focusNode;
    _listScrollController;
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openAiLogo),
        ),
        title: const Text(
          "ChatGPT",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  backgroundColor: scaffoldBackgroundColor,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 70,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Choose Model: ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Flexible(child: DropDownMenu())
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                controller: _listScrollController,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    index:
                        listMessages[index].chatIndex,
                    msg: listMessages[index].message,
                  );
                },
                itemCount: listMessages.length,
              ),
            ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            SizedBox(
              height: 12.0,
            ),
            Container(
              color: cardColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: focusNode,
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(provider);
                        },
                        decoration: InputDecoration(
                            hintText: "How can I help you",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await sendMessageFCT(provider);

                      },
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void listScroll()
  {
    _listScrollController.animateTo(_listScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 500 ), curve: Curves.easeOut);
  }



  Future<void> sendMessageFCT(ProviderModel provider)  async
  {
    try
    {
      if(textEditingController.text.isEmpty || textEditingController.text == null)
      {
        setState(() {
          _isTyping = false;
        });
        final snackBar = SnackBar(backgroundColor: Colors.red,duration:Duration(seconds: 1),content: Text("Please type a message!!!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // print("not returning");

        return;
      }
      setState(() {
        _isTyping = true;
         listMessages.add(ChatModel(message: textEditingController.text, chatIndex:0 ));
        textEditingController.clear();
        focusNode.unfocus();
      });

      provider.getDataFromApiProvider();
     messagesReplied = await ApiService().sendMessage(textEditingController.text);
     listMessages.add(messagesReplied);
    }
    catch (error)
    {
      log("error: $error");
      final snackBar = SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.red,content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    finally
    {
      setState(() {
        _isTyping = false;
      });
    }
    setState(() {
      listScroll();
      _isTyping = false;
    });

  }
}


