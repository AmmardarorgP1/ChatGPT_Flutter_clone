// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_clone/services/Asset_manager.dart';
import 'package:flutter/material.dart';

import '../consts/consts.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.index, required this.msg});

  final int index;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index == 0 ? scaffoldBackgroundColor : cardColor,
      child: ListTile(
        leading: index == 0
            ? CircleAvatar(
                radius: 15.0,
                child: Image.asset(
                  AssetsManager.personLogo,
                  fit: BoxFit.cover,
                ))
            : CircleAvatar(
                radius: 15.0,
                child: Image.asset(
                  AssetsManager.chatLogo,
                  fit: BoxFit.cover,
                )),
        title: index == 0
            ? Text(
                msg,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              )
            : DefaultTextStyle(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    totalRepeatCount: 1,
                    animatedTexts: [TyperAnimatedText(msg.trim())])),
      ),
    );
    // : Container(
    //     color: index == 0 ? scaffoldBackgroundColor : cardColor,
    //     child: ListTile(
    //       leading: index == 0
    //           ? CircleAvatar(
    //               radius: 15.0,
    //               child: Image.asset(
    //                 AssetsManager.chatLogo,
    //                 fit: BoxFit.cover,
    //               ))
    //           : CircleAvatar(
    //               radius: 15.0,
    //               child: Image.asset(
    //                 AssetsManager.personLogo,
    //                 fit: BoxFit.cover,
    //               )),
    //       title: Text(
    //         msg,
    //         style: TextStyle(color: Colors.white),
    //       ),
    //       trailing: Column(
    //         children: [
    //           Icon(
    //             Icons.thumb_up_alt_outlined,
    //             size: 20,
    //             color: Colors.white,
    //           ),
    //           SizedBox(
    //             height: 15,
    //           ),
    //           Icon(
    //             Icons.thumb_down_alt_outlined,
    //             size: 20,
    //             color: Colors.white,
    //           )
    //         ],
    //       ),
    //     ),
    //   );
  }
}
