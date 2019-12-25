import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/logo_text.dart';
import '../widgets/rounded_button.dart';
import './login_screen.dart';
import './home_screen.dart';

enum Gender {
  Male,
  Female,
}

class SignupScreen2 extends StatefulWidget {
  static const routeName = '/register-complete';

  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Gender _gender;
  Map<String, String> _data = {
    'name': '',
    'email': '',
    'password': '',
    'gender': '',
  };
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.post(
          'https://ffds-new.herokuapp.com/register?email=${_data['email']}&name=${_data['name']}&gender=${_data['gender']}&password=${_data['password']}');
      final responseBody = json.decode(response.body);
      setState(() {
        _isLoading = false;
      });

      if (responseBody == 'Registered Successfully') {
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Success'),
            content: Text(responseBody),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName, ModalRoute.withName(HomeScreen.routeName));
      } else {
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text(responseBody),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
    } catch (e) {}
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
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewPadding.top),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
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
                        )
                      ],
                    ),
                    _isLoading
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Color(0xFF06AE71),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Full Name',
                                        style: TextStyle(
                                          fontFamily: 'BarlowSemiCondensed',
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Color(0xFFBDB3B3),
                                            size: 30,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          errorStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Color(0xFFBDB3B3),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['name'] = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'VIT Gmail',
                                        style: TextStyle(
                                          fontFamily: 'BarlowSemiCondensed',
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Color(0xFFBDB3B3),
                                            size: 30,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          errorStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Color(0xFFBDB3B3),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                          if (!RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.]+@vitstudent.ac.in")
                                              .hasMatch(value)) {
                                            return 'Please enter a valid VIT gmail id.';
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (value) {
                                          _data['email'] = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                          fontFamily: 'BarlowSemiCondensed',
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Color(0xFFBDB3B3),
                                            size: 30,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          errorStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Color(0xFFBDB3B3),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must contain minimum 6 characters.';
                                          }
                                        },
                                        onSaved: (value) {
                                          _data['password'] = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Confirm Password',
                                        style: TextStyle(
                                          fontFamily: 'BarlowSemiCondensed',
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Color(0xFFBDB3B3),
                                            size: 30,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          errorStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Color(0xFFBDB3B3),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == '') {
                                            return 'This field is required.';
                                          }
                                          if (value !=
                                              passwordController.text) {
                                            return 'Passwords do not match.';
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Gender',
                                        style: TextStyle(
                                          fontFamily: 'BarlowSemiCondensed',
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Radio(
                                            activeColor: Color(0xFF06aE71),
                                            value: Gender.Male,
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value;
                                                _data['gender'] =
                                                    describeEnum(_gender);
                                              });
                                            },
                                          ),
                                          Text('Male'),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                          ),
                                          Radio(
                                            activeColor: Color(0xFF06aE71),
                                            value: Gender.Female,
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value;
                                                _data['gender'] =
                                                    describeEnum(_gender);
                                              });
                                            },
                                          ),
                                          Text('Female'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RoundedButton(
                                        title: 'Register',
                                        onPressed: _submit,
                                        borderColor: Color(0xFF06AE71),
                                        color: Color(0xFF06AE71),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
