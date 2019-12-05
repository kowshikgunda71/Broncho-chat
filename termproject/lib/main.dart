import 'package:flutter/material.dart';
import 'package:termproject/screens/index.dart';
import 'package:termproject/screens/offline.dart';
import './screens/welcome_screen.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';
import './screens/chat_screen.dart';
import './screens/profilePage.dart';
import './screens/imageshare.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Offline.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ProfilePage.id: (context) => ProfilePage(),
        Offline.id: (context) => Offline(),
        ImagePage.id: (context) => ImagePage(),
        IndexPage.id: (context) => IndexPage(),
      },
    );
  }
}
