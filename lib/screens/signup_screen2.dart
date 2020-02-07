import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../helper/mailer.dart';
import '../widgets/logo_text.dart';
import '../widgets/rounded_button.dart';
import '../helper/auth.dart';
import '../helper/http_exception.dart';
import './login_screen.dart';
import './home_screen.dart';
import 'package:http/http.dart' as http;

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
    'phone': '',
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
      await Provider.of<Auth>(context, listen: false).signup(_data);
    } on HttpException catch (e) {
      if (e.toString() == 'Mail could not be sent.') {
        final res = await http.post(
            'https://ffds-new.herokuapp.com/send?mailto=${_data['email']}');
        final resBody = json.decode(res.body);
        if (resBody == 'error') {
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'Error',
            desc: 'Some error occurred. Please contact the developer.',
            btnOkOnPress: () {},
          ).show();
        }
      } else if (e.toString() == 'Mail Sent') {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Registered Successfully',
          desc:
              'A verification link has been sent to your email. Please verify your account.',
          btnOkOnPress: () {},
        ).show();
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName, ModalRoute.withName(HomeScreen.routeName));
      } else if (e.toString() == 'Email exists') {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Invalid Email',
          desc: 'This email is already in use. Please use some other email.',
          btnOkOnPress: () {},
        ).show();
      } else {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Some Error occurred',
          desc: 'Some error occurred. Could not authenticate you.',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        tittle: 'Some Error occurred',
        desc: 'Some error occurred. Could not authenticate you.',
        btnOkOnPress: () {},
      ).show();
    }
    setState(() {
      passwordController.clear();
      _gender = null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final phoneNo = ModalRoute.of(context).settings.arguments;
    _data['phone'] = phoneNo.toString();

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
                        ),
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
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
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
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      FittedBox(
                                        child: Row(
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
