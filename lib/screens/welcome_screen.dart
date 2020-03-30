import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  // Create an id here to avoid problems with string.
  // Make it static so that the variable is associated with the class
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// SingleTickerProviderStateMixin is needed for the vsync property inside of the AnimationController.
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // Create a variable called controller that can hold an AnimationController
  AnimationController controller;

  // Create a variable called animation that can hold an Animation
  Animation animation;
  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Adds a curved animation to the controller.
    // Curved as in the value changes in a fashion to my desire.
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    // Tells the controller to move forward with the animation. Use controller.reverse(from: 1.0); to play around with this.
    controller.forward();

    // Need a listener to be called each time the controller does something.
    // Need set state to tell Flutter that a value is dirty. Without out setstate, no animation will happen.
    controller.addListener(() {
      setState(() {});
//      print(controller.value);
      print(animation.value);
    });
  }

  // Removes the controller to free up resources. Without this code, the controller will won't go away.
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // withOpacity changes the transparency of the background
//      backgroundColor: Colors.red.withOpacity(controller.value),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Hero Widget for animations. Must have the same tag as the Hero Widget in registration_screen.dart
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
//                    Because animation.value ranges between 0 - 1, you wont see a difference in height that much. Therefore x100
                    height: animation.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  isRepeatingAnimation: false,
                  speed: Duration(milliseconds: 200),
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  text: ['Flash Chat'],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
