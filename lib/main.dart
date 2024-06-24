// ignore_for_file: prefer_const_constructors

import '../provider/Provider.dart';
import '../consts/consts.dart';
import '../screens/Chat_screen.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> ProviderModel())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          color: cardColor
        )
      ),
    ),
  ));
}
