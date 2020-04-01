import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './http_exception.dart';

class Auth extends ChangeNotifier {
  // String _email = 'vansh.goel2018@vitstudent.ac.in';
  String _email;
  String _name;
  String _gender;
  String _phone;
  String _bio;
  String _exp;
  String _branch;

  String get email {
    return _email;
  }

  String get name {
    return _name;
  }

  String get gender {
    return _gender;
  }

  String get phone {
    return _phone;
  }

  String get bio {
    return _bio;
  }

  String get exp {
    return _exp;
  }

  String get branch {
    return _branch;
  }

  bool get isAuth {
    return _email != null;
  }

  Future<void> login(Map<String, String> credentials) async {
    try {
      final response = await http.post(
          'https://ffds-new.herokuapp.com/login?email=${credentials['email']}&password=${credentials['password']}');
      final responseBody = json.decode(response.body);
      if (responseBody['response'] == 'Login successful') {
        final isVerified = await http.post(
            'https://ffds-new.herokuapp.com/verifyemail?email=${credentials['email']}');
        final isVerifiedMessage = json.decode(isVerified.body);
        if (isVerifiedMessage == 'email not verified') {
          throw HttpException('email not verified');
        }
        _email = credentials['email'];
        notifyListeners();
        throw HttpException('success');
      } else if (responseBody['response'] == 'Invalid Password') {
        throw HttpException('Invalid Password');
      } else {
        throw HttpException('email not registered');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(Map<String, String> data) async {
    try {
      final response = await http.post(
          'https://ffds-new.herokuapp.com/register?email=${data['email']}&name=${data['name']}&gender=${data['gender']}&password=${data['password']}&phone=${data['phone']}');
      final responseBody = json.decode(response.body);
      if (responseBody == 'Registered Successful') {
        final emailResponse = await http.post(
            'https://ffds-new.herokuapp.com/send?mailto=${data['email']}');
        final emailResponseBody = json.decode(emailResponse.body);
        if (emailResponseBody == 'error') {
          throw HttpException('Mail could not be sent.');
        }
        throw HttpException('Mail Sent');
      } else {
        throw HttpException('Email exists');
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> getUserData() async {
    try {
      final response = await http
          .post('https://ffds-new.herokuapp.com/showDetails?email=$_email');
      final responseBody = json.decode(response.body);
      _name = responseBody['name'];
      _gender = responseBody['gender'];
      _phone = responseBody['phone'].toString();
      _bio = responseBody['bio'];
      _exp = responseBody['expectations'];
      _branch = responseBody['branch'];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserData(String bio, String exp) async {
    try {
      await http.post(
          'https://ffds-new.herokuapp.com/updateDetails?email=vansh.goel2018@vitstudent.ac.in&expectations=$exp&bio=$bio');
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    _email = null;
    notifyListeners();
  }
}
