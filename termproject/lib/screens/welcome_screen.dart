import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import '../components/rounded_button.dart';
import '../screens/google_screen.dart';
import 'chat_screen.dart';
//import 'package:flutter_offline/flutter_offline.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation back;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    back = ColorTween(begin: Colors.blue[900], end: Colors.amberAccent)
        .animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: back.value,
     
      body: 

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'uco',
                  child: Container(
                    child: Image.asset('images/uco.png'),
                    height: animation.value * 100,
                  ),
                ),
                Text(
                  'Bronco chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            RoundedButton(
              title: 'google sign in ',
              colour: Colors.blueAccent,
              onPressed: () async {
                bool res = await AuthProvider().loginWithGoogle();
                if (!res)
                  print("error logging in with google");
                else {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*class RoundedButton extends StatelessWidget {
RoundedButton({this.title,this.colour,@required this.onPressed});
final Color colour;
final String title;
final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
*/
