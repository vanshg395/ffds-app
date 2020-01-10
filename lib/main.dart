import 'package:ffds/screens/userScreen/tabsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen1.dart';
import './screens/signup_screen2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'BarlowSemiCondensed'),
        ),
      ),
      // initialRoute: HomeScreen.routeName,
      initialRoute: TabsScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen1.routeName: (context) => SignupScreen1(),
        SignupScreen2.routeName: (context) => SignupScreen2(),
        TabsScreen.routeName: (context) => TabsScreen(),
      },
    );
  }
}
