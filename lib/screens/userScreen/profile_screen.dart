import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/logo_text.dart';
import '../../helper/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum Expectations {
  Friendship,
  Hangout,
  Relationship,
  Hookup,
}

class _ProfileScreenState extends State<ProfileScreen> {
  Expectations _expectation;
  File _timetable;
  TextEditingController bio = TextEditingController();
  bool _editBio = false;
  bool _editExp = false;
  bool _isLoading = false;

  String _name = '';
  String _gender = '';
  String _phone = '';
  String _branch = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _name = Provider.of<Auth>(context, listen: false).name;
        _gender = Provider.of<Auth>(context, listen: false).gender;
        _phone = Provider.of<Auth>(context, listen: false).phone;
        bio.text = Provider.of<Auth>(context, listen: false).bio;
        if (Provider.of<Auth>(context, listen: false).exp == 'Relationship') {
          _expectation = Expectations.Relationship;
        } else if (Provider.of<Auth>(context, listen: false).exp ==
            'Friendship') {
          _expectation = Expectations.Friendship;
        } else if (Provider.of<Auth>(context, listen: false).exp == 'Hangout') {
          _expectation = Expectations.Hangout;
        } else if (Provider.of<Auth>(context, listen: false).exp == 'Hookup') {
          _expectation = Expectations.Hookup;
        }
        _branch = Provider.of<Auth>(context, listen: false).branch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: Color(0xFF06AE71),
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        _name.toUpperCase() ?? '',
                        style: TextStyle(
                          color: Color(0xFF06AE71),
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        _gender ?? '',
                        style: TextStyle(
                          color: Color(0xFF06AE71),
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        _phone ?? '',
                        style: TextStyle(
                          color: Color(0xFF06AE71),
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Branch',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        _branch ?? '',
                        style: TextStyle(
                          color: Color(0xFF06AE71),
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'About Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          IconButton(
                            icon: Icon(_editBio ? Icons.save : Icons.edit),
                            onPressed: () async {
                              setState(() {
                                _editBio = !_editBio;
                              });
                              if (!_editBio) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Provider.of<Auth>(context, listen: false)
                                    .updateUserData(
                                        bio.text, describeEnum(_expectation));
                                await Provider.of<Auth>(context, listen: false)
                                    .getUserData();
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: TextField(
                          enabled: _editBio,
                          controller: bio,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          maxLines: 5,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
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
                            fillColor: _editBio ? Colors.white : Colors.grey,
                            errorStyle: TextStyle(
                              fontSize: 14,
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xFFBDB3B3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Expectations',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          IconButton(
                            icon: Icon(_editExp ? Icons.save : Icons.edit),
                            onPressed: () async {
                              setState(() {
                                _editExp = !_editExp;
                              });
                              if (!_editExp) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Provider.of<Auth>(context, listen: false)
                                    .updateUserData(
                                        bio.text, describeEnum(_expectation));
                                await Provider.of<Auth>(context, listen: false)
                                    .getUserData();
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Color(0xFF06aE71),
                                      value: Expectations.Friendship,
                                      groupValue: _expectation,
                                      onChanged: _editExp
                                          ? (value) {
                                              setState(() {
                                                _expectation = value;
                                              });
                                            }
                                          : null,
                                    ),
                                    Text('Friendship'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Color(0xFF06aE71),
                                      value: Expectations.Hangout,
                                      groupValue: _expectation,
                                      onChanged: _editExp
                                          ? (value) {
                                              setState(() {
                                                _expectation = value;
                                                // _data['gender'] = describeEnum(_gender);
                                              });
                                            }
                                          : null,
                                    ),
                                    Text('Hangout'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Color(0xFF06aE71),
                                      value: Expectations.Relationship,
                                      groupValue: _expectation,
                                      onChanged: _editExp
                                          ? (value) {
                                              setState(() {
                                                _expectation = value;
                                              });
                                            }
                                          : null,
                                    ),
                                    Text('Relationship'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      activeColor: Color(0xFF06aE71),
                                      value: Expectations.Hookup,
                                      groupValue: _expectation,
                                      onChanged: _editExp
                                          ? (value) {
                                              setState(() {
                                                _expectation = value;
                                              });
                                            }
                                          : null,
                                    ),
                                    Text('Hookup'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Timetable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Upload Timetable',
                            style: TextStyle(
                              color: Color(0xFF06AE71),
                              fontSize: 32,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: IconButton(
                              icon: Icon(
                                Icons.cloud_upload,
                                size: 40,
                                color: _timetable != null
                                    ? Color(0xFF3D3D3D)
                                    : Color(0xFF06AE71),
                              ),
                              onPressed: _timetable != null
                                  ? null
                                  : () async {
                                      _timetable = await ImagePicker.pickImage(
                                          source: ImageSource.gallery);
                                      setState(() {});
                                    },
                            ),
                          )
                        ],
                      ),
                      _timetable != null
                          ? Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Image.file(
                                _timetable,
                                fit: BoxFit.fitHeight,
                                height: 100,
                              ),
                            )
                          : Text('No Timetable Uploaded'),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xAA000000),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xFF06AE71),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
