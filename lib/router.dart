
import 'package:flutter/material.dart';
import 'package:eliana_chatbot/main.dart';
import 'package:eliana_chatbot/chatpage.dart';
const String FACTS_DIALOGFLOW = "FACTS_DIALOGFLOW";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch(routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => MyHomePage());
      break;
    case FACTS_DIALOGFLOW:
      return MaterialPageRoute(builder: (context) => ChatScreen());
      break;
    default:
    return MaterialPageRoute(builder: (context) => MyHomePage());
  }
  

  }
