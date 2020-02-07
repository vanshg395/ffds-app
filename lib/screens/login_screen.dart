import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';

import '../helper/http_exception.dart';
import '../widgets/rounded_button.dart';
import '../helper/auth.dart';
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
      await Provider.of<Auth>(context, listen: false).login(_credentials);
    } on HttpException catch (e) {
      if (e.toString() == 'email not verified') {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Email Not Verified',
          desc: 'Your email is not verified. Please verify your email.',
          btnOkOnPress: () {},
        ).show();
      } else if (e.toString() == 'Invalid Password') {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Invalid Credentials',
          desc: 'Email and Password combination do no match.',
          btnOkOnPress: () {},
        ).show();
      } else if (e.toString() == 'email not registered') {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          tittle: 'Invalid Email',
          desc:
              'This email id is not registered. Please sign up using this email.',
          btnOkOnPress: () {},
        ).show();
      } else if (e.toString() == 'success') {
        Navigator.of(context).pop();
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
                                backgroundColor: Color(0xFF06AE71),
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
