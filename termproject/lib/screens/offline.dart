import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../screens/welcome_screen.dart';

class Offline extends StatelessWidget {
  static const String id = "Offline";
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        debounceDuration: Duration.zero,
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          if (connectivity == ConnectivityResult.none) {
            return Container(
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  "Oops, \n\nWe experienced a Delayed Offline!",
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
            );
          }
          return child;
        },
        child: FlatButton(
          onPressed: () {
          Navigator.pushNamed(context, WelcomeScreen.id);
        }, 
          padding: EdgeInsets.all(0.0),
          child: Image.asset('images/uco.png'),
        ));
  }
}
