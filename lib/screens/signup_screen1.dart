import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './signup_screen2.dart';
import '../widgets/logo_text.dart';
import '../widgets/rounded_button.dart';

class SignupScreen1 extends StatefulWidget {
  @override
  _SignupScreen1State createState() => _SignupScreen1State();

  static const routeName = '/register';
}

class _SignupScreen1State extends State<SignupScreen1> {
  FocusNode otpFocusNode1 = FocusNode();
  FocusNode otpFocusNode2 = FocusNode();
  FocusNode otpFocusNode3 = FocusNode();
  FocusNode otpFocusNode4 = FocusNode();
  bool _isOtpSent = false;
  TextEditingController _phoneNumber = TextEditingController();
  int _generatedOtp;
  List<TextEditingController> enteredOtpController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  String enteredOtp = '';
  String _errorText;

  void generateOtp() {
    _generatedOtp = Random().nextInt(9000) + 1000;
    print(_generatedOtp);
  }

  Future<void> sendOtp() async {
    generateOtp();
    try {
      // final response = await http.post(
      // 'https://api.msg91.com/api/v5/otp?authkey=309733AvsnLTQSW5e00de5eP1&template_id=5e00e66cd6fc0561ae3cc993&extra_param={"OTP":$_generatedOtp}&mobile=${'+91' + _phoneNumber.text}&invisible=1&otp=OTP to send and verify. If not sent, OTP will be generated.&userip=IPV4 User IP&email=Email ID');
      // print(response.body);
    } catch (e) {
      print(e);
    }
  }

  void verifyOtp() {
    String temp = '';
    for (var digit in enteredOtpController) {
      temp += digit.text;
    }
    enteredOtp = temp;
    if (_generatedOtp.toString() == enteredOtp) {
      print('Verified');
      Navigator.of(context).pushReplacementNamed(SignupScreen2.routeName,
          arguments: _phoneNumber.text);
    } else {
      print('Invalid Otp');
      enteredOtpController.forEach((digit) {
        digit.clear();
        setState(() {});
        FocusScope.of(context).requestFocus(otpFocusNode1);
      });
    }
  }

  Widget buildScreenA() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              child: Icon(
                Icons.phone_iphone,
                size: 100,
                color: Color(0xFF06AE71),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(
                  'Please enter your mobile number for verification',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _phoneNumber,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xFF06AE71),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(
                  color: Color(0xFFBDB3B3),
                ),
                errorText: _errorText,
                errorStyle: TextStyle(fontSize: 14),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 40,
            ),
            Hero(
              tag: 'signup',
              child: RoundedButton(
                title: 'Send OTP',
                color: Color(0xFF06AE71),
                borderColor: Color(0xFF06AE71),
                onPressed: () {
                  setState(() {
                    if (_phoneNumber.text.length != 10) {
                      setState(() {
                        _errorText = 'Please enter a valid phone number.';
                      });
                      return;
                    }
                    sendOtp();
                    enteredOtpController.forEach((digit) {
                      digit.clear();
                    });
                    _isOtpSent = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScreenB() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              child: Text(
                'The OTP has been sent to \n${_phoneNumber.text}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              child: Text(
                'Change Number',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF06AE71),
                ),
              ),
              onPressed: () {
                _phoneNumber.clear();
                setState(() {
                  _errorText = '';
                  _isOtpSent = false;
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxWidth: 60),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      focusNode: otpFocusNode1,
                      controller: enteredOtpController[0],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          return;
                        }
                        FocusScope.of(context).requestFocus(otpFocusNode2);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 60),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      focusNode: otpFocusNode2,
                      controller: enteredOtpController[1],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          FocusScope.of(context).requestFocus(otpFocusNode1);
                          return;
                        }
                        FocusScope.of(context).requestFocus(otpFocusNode3);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 60),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      focusNode: otpFocusNode3,
                      controller: enteredOtpController[2],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          FocusScope.of(context).requestFocus(otpFocusNode2);
                          return;
                        }
                        FocusScope.of(context).requestFocus(otpFocusNode4);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 60),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      focusNode: otpFocusNode4,
                      controller: enteredOtpController[3],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value == '') {
                          FocusScope.of(context).requestFocus(otpFocusNode3);
                          return;
                        }
                        verifyOtp();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF06AE71),
                ),
                color: Color(0xFF06AE71),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
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
                        ),
                      ],
                    ),
                    _isOtpSent ? buildScreenB() : buildScreenA(),
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
