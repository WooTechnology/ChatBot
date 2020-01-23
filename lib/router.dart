import 'package:eliana_chatbot/home.dart';
import 'package:eliana_chatbot/splash.dart';
import 'package:flutter/material.dart';
import 'package:eliana_chatbot/chat_page.dart';

const String chat_page = "CHAT_PAGE";
const String home_page = "HOME_PAGE";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => SplashScreen());
      break;
    case home_page:
      return MaterialPageRoute(builder: (context) => HomePage());
      break;
    case chat_page:
      return MaterialPageRoute(builder: (context) => ChatScreen());
      break;
    default:
      return MaterialPageRoute(builder: (context) => HomePage());
  }
}
