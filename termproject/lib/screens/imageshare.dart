import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ImagePage extends StatefulWidget {
  static const String id = "imagePage";
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final _firestore = Firestore.instance;
  File _image;
  String _downloadUrl;
  StorageReference firebaseStorageRef;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    void getCurrentUser() async {
      try {
        final user = await _auth.currentUser();
        if (user != null) {
          loggedInUser = user;
          print(loggedInUser.email);
        }
      } catch (e) {}
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print(" Image uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Image Uploaded')));
      });
    }

    Future downloadImage() async {
      String downloadAddress = await firebaseStorageRef.getDownloadURL();
      setState(() {
        _downloadUrl = downloadAddress;
      });
    }

    return Scaffold(
        body: Builder(
            builder: (context) => Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                size: 30.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Color(0xff476cfb),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                          RaisedButton(
                            color: Color(0xff476cfb),
                            onPressed: () {
                              uploadPic(context);
                            },
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                          RaisedButton(
                            color: Color(0xff476cfb),
                            onPressed: () {
                              downloadImage();
                            },
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'download',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              //Implement send functionality.
                              //messagetext+ loggedInUser.email
                              _firestore.collection('messages').add({
                                'text': _downloadUrl,
                                'sender': loggedInUser.email,
                              });
                            },
                            child: Text(
                              'send image',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )));
  }
}
