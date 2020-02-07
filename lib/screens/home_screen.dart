import 'package:flutter/material.dart';

import '../widgets/rounded_button.dart';
import '../widgets/logo_text.dart';
import './login_screen.dart';
import './signup_screen1.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                heightFactor: 2,
                child: Text('made with ❤️ from CodeChef-VIT'),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: FittedBox(
                      child: LogoText(
                        'large',
                        Color(0xFF06AD71),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'loginButton',
                      child: RoundedButton(
                        title: 'LOGIN',
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF06AD71),
                            Color(0xFF055E3E),
                          ],
                        ),
                        borderColor: Color(0xFF06AD71),
                        width: MediaQuery.of(context).size.width * 0.7,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Hero(
                      tag: 'signup',
                      child: RoundedButton(
                        title: 'SIGN UP',
                        color: Color(0xFF06AD71),
                        borderColor: Color(0xFF06AD71),
                        width: MediaQuery.of(context).size.width * 0.7,
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignupScreen1.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
