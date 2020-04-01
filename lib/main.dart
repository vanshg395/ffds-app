import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/userScreen/tabsScreen.dart';
import './helper/auth.dart';
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
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
              textTheme: TextTheme(
                body1: TextStyle(fontFamily: 'CircularStdBook'),
              ),
            ),
            // initialRoute: HomeScreen.routeName,
            // initialRoute:
            //     auth.isAuth ? TabsScreen.routeName : HomeScreen.routeName,
            home: auth.isAuth ? TabsScreen() : HomeScreen(),
            routes: {
              // HomeScreen.routeName: (context) => HomeScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              SignupScreen1.routeName: (context) => SignupScreen1(),
              SignupScreen2.routeName: (context) => SignupScreen2(),
              TabsScreen.routeName: (context) => TabsScreen(),
            },
          );
        },
      ),
    );
  }
}
