import 'package:flutter/material.dart';

import '../widgets/rounded_button.dart';
import '../widgets/logo_text.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  final GlobalKey<FormState> _formKey = GlobalKey();

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
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewPadding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF06AD71),
                            Color(0xFF055E3E),
                          ],
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            FittedBox(child: LogoText('small', Colors.white)),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                // errorText: 'Hello',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5),
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xFFBDB3B3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                  color: Color(0xFFBDB3B3),
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@vitstudent.ac.in")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid VIT gmail id.';
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5),
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xFFBDB3B3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                  color: Color(0xFFBDB3B3),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Hero(
                              tag: 'loginButton',
                              child: RoundedButton(
                                title: 'LOGIN',
                                width: MediaQuery.of(context).size.width * 0.7,
                                onPressed: () {
                                  _formKey.currentState.validate();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
