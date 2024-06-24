// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import '../models/ChatModel.dart';
import '../models/Model.dart';
import '../consts/API_key.dart';

class ApiService {
  Future<API_MODEL> getModel() async {
    final String url = "https://api.openai.com/v1/models";

    final response = await get(Uri.parse(Uri.encodeFull(url)),
        headers: {"Authorization": "Bearer $API_KEY"});

    if (response.statusCode == 200) {
      Map jsonDecode = json.decode(response.body);
      print(jsonDecode);
      if (jsonDecode['error'] != null) {
        print("Response['error']: $jsonDecode['error']['message']");
        throw Exception(jsonDecode['error']['message']);
      }
      return API_MODEL.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error in rsponse from API");
    }
  }

  Future<ChatModel> sendMessage(String message) async {
    const String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$API_KEY_Gemini"; // Gemini API used for sending message

    final response = await post(Uri.parse(Uri.encodeFull(url)),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": message}
              ]
            }
          ]
        }));

    if (response.statusCode == 200)
    {
      Map jsonDecode = json.decode(response.body);

      if (jsonDecode['error'] != null) {
        log("Response['error']: $jsonDecode['error']['message']");
        throw Exception(jsonDecode['error']['message']);
      }
      log("On sending message to API:  ${jsonDecode["candidates"][0]["content"]["parts"][0]["text"]}");
      return ChatModel(message: jsonDecode["candidates"][0]["content"]["parts"][0]["text"], chatIndex: 1);
    }
    else {
      throw Exception("Error in sending message to API");
    }
  }
}
