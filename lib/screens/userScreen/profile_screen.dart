import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/logo_text.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                    'ABC XYZ',
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
                    'Male',
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
                    '9876543210',
                    style: TextStyle(
                      color: Color(0xFF06AE71),
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'About Me',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      // enabled: false,
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
                        fillColor: Colors.white,
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
                  Text(
                    'Expectations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
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
                                  onChanged: (value) {
                                    setState(() {
                                      _expectation = value;
                                      // _data['gender'] = describeEnum(_gender);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _expectation = value;
                                      // _data['gender'] = describeEnum(_gender);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _expectation = value;
                                      // _gender = value;
                                      // _data['gender'] = describeEnum(_gender);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      // _gender = value;
                                      _expectation = value;
                                      // _data['gender'] = describeEnum(_gender);
                                    });
                                  },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
