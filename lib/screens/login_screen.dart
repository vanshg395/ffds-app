import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/rounded_button.dart';
import '../widgets/logo_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _credentials = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
          'https://ffds-new.herokuapp.com/login?email=${_credentials['email']}&password=${_credentials['password']}');

      final responseBody = json.decode(response.body);
      if (responseBody['response'] == 'Login successful') {
        print('Mubarak Ho! Aapko jald hi ladki mil jaegi');
      } else {
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text(responseBody),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

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
                    Stack(
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
                            ),
                          ],
                        ),
                        Container(
                          constraints: BoxConstraints(maxHeight: 60),
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: LogoText(
                              'small',
                              Color(0xFF06AD71),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _isLoading
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Color(0xFF06aE71),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
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
                                  FittedBox(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        fontSize: 56,
                                        fontFamily: 'BarlowSemiCondensed',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      hintText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Color(0xFFBDB3B3),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                        color: Color(0xFFBDB3B3),
                                      ),
                                      errorStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field is required.';
                                      }
                                      if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@vitstudent.ac.in")
                                          .hasMatch(value)) {
                                        return 'Please enter a valid VIT gmail id.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _credentials['email'] = value;
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
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                        color: Color(0xFFBDB3B3),
                                      ),
                                      errorStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field is required.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _credentials['password'] = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Hero(
                                    tag: 'loginButton',
                                    child: RoundedButton(
                                      title: 'LOGIN',
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      onPressed: _submit,
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
