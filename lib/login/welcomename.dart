// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mu_card/apiConnection/apiConnection.dart';
import 'package:mu_card/dashboard.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mu_card/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeName extends StatefulWidget {
  static String welcomeName = '';
  static String welcomeEmail = '';
  static int id = 0;
  static String phoneNum = '';
  WelcomeName({super.key, required String phoneNum}) {
    WelcomeName.phoneNum = phoneNum;
  }

  @override
  State<WelcomeName> createState() => _WelcomeNameState();
}

class _WelcomeNameState extends State<WelcomeName> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  bool referralVisibility = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // stops: [0.5, 0.5],
        colors: [
          Color.fromARGB(255, 0, 255, 251),
          Colors.white,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                      child: Container(
                        height: 17,
                        width: 280,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            backgroundColor: Color.fromARGB(255, 178, 178, 178),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 246, 255, 0)),
                            value: 0.25,
                            minHeight: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 70, 0, 0),
                      child: Text(
                        'Welcome to MU',
                        style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 2,
                            // color: Color.fromARGB(255, 255, 255, 255),
                            color: Color.fromARGB(255, 38, 36, 36),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'Let\'s get started...',
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            color: Color.fromARGB(255, 121, 121, 121),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 55, 0, 0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Color.fromARGB(255, 38, 36, 36),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: SizedBox(
                    // height: 50,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return null;
                      },
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          letterSpacing: 1.1,
                          fontFamily: 'Times New Roman'),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        'Email ID',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Color.fromARGB(255, 38, 36, 36),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: SizedBox(
                    // height: 50,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          letterSpacing: 1.1,
                          fontFamily: 'Times New Roman'),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (referralVisibility == true) {
                              referralVisibility = false;
                            } else {
                              referralVisibility = true;
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50, 25),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'I have referral code',
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1,
                              color: Color.fromARGB(255, 255, 187, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: referralVisibility,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 220,
                          child: TextFormField(
                            controller: referralController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 1,
                                fontFamily: 'Times New Roman'),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.all(5),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  color: Color.fromARGB(255, 255, 187, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: SizedBox(
                        height: 50,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              validateEmail();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('All Fields Are Required!')),
                              );
                            }
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Color.fromARGB(255, 238, 255, 0),
                                fontSize: 21,
                                letterSpacing: 1.4),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color.fromARGB(130, 48, 40, 40), // background
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validEmail), body: {
        'email': emailController.text.trim(),
      });

      if (res.statusCode == 200) {
        var resBodyOfEmail = jsonDecode(res.body);
        if (resBodyOfEmail['emailFound']) {
          print("Email already exist");
          Fluttertoast.showToast(msg: "Email already exist");
        } else {
          saveUser();
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void saveUser() async {
    User userModel = User(nameController.text.trim(),
        emailController.text.trim(), WelcomeName.phoneNum);
    try {
      var res = await http.post(Uri.parse(API.sigup), body: userModel.toJson());

      if (res.statusCode == 200) {
        var resBodyOfSignup = jsonDecode(res.body);
        if (resBodyOfSignup['success']) {
          int id = resBodyOfSignup['id'];
          print("User Id :" + id.toString());
          final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isLogin', true);
                  await prefs.setInt('userId', id);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login successfullly')));
          Get.off(() => Dashboard(userId: id));
        } else {
          print("Sorry!!");
          Fluttertoast.showToast(msg: "Error Sorry!!!!");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
