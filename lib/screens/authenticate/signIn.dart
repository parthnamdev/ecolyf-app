// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignIn extends StatefulWidget {
  final Function? func;
  // ignore: use_key_in_widget_constructors
  const SignIn({this.func});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String password = "";
  String email = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  String? value;
  final storage = FlutterSecureStorage();
  var dio = Dio();
  Future<String?> check() async {
    const storage = FlutterSecureStorage();
    value = await storage.read(key: "token");
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: kLight,
      appBar: AppBar(
        title: Text('Welcome back!'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 20.0,
        foregroundColor: kDark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding * 1.2),
          height: 70 * 10,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextFormField(
                      // decoration: InputDecoration(
                      //   labelText: 'USERNAME OR EMAIL',
                      //   labelStyle: TextStyle(
                      //     // fontFamily: 'Raleway',
                      //     fontSize: 12.0,
                      //     // color: Colors.grey.withOpacity(0.5),
                      //   ),
                      //   focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: kPrimaryColor),
                      //   ),
                      // ),
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                          // fontFamily: 'Raleway',
                          fontSize: 16.0,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kPrimaryColor
                              : kDark[900],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: kDefaultPadding),
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kPrimaryColor
                                      : kDark[900]!),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (val) {
                        if (RegExp(
                                r"(^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+)")
                            .hasMatch(val!)) {
                          setState(() {
                            email = val;
                          });
                          return null;
                        }
                        // if (!RegExp(r"^[a-zA-Z0-9!#$%&-^_]+").hasMatch(val)) {
                        // if (!RegExp(r"^(?=[a-zA-Z0-9._]{5,32}$)")
                        //     .hasMatch(val)) {
                        //   return 'Please enter a valid username or email';
                        // }
                        // return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      // decoration: InputDecoration(
                      //   labelText: 'PASSWORD',
                      //   labelStyle: TextStyle(
                      //     // fontFamily: 'Raleway',
                      //     fontSize: 12.0,
                      //     // color: Colors.grey.withOpacity(0.5),
                      //   ),
                      //   focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: kPrimaryColor),
                      //   ),
                      // ),
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                          // fontFamily: 'Raleway',
                          fontSize: 16.0,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kPrimaryColor
                              : kDark[900],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: kDefaultPadding),
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? kPrimaryColor
                                      : kDark[900]!),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (val) => val!.length < 6
                          ? 'Enter password 6+ characters long'
                          : null,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 30.0),
                    Center(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                    GestureDetector(
                      // onTap: () async {
                      //   if (_formKey.currentState!.validate()) {
                      //     dynamic result =
                      //         await _auth.signInWithEmailAndPassword(
                      //             username, password);
                      //     if (result == null) {
                      //       if (this.mounted) {
                      //         setState(() {
                      //           error = "Something went wrong";
                      //         });
                      //       }
                      //     }
                      //   }
                      // },
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          Response response = await dio.post(
                            'https://api-ecolyf-alt.herokuapp.com/user/login',
                            options: Options(headers: {
                              HttpHeaders.contentTypeHeader: "application/json",
                            }),
                            // data: jsonEncode(value),
                            data: {"email": email, "password": password},
                          );
                          if (response.data['status'] != true) {
                            setState(() {
                              error = response.data['message'];
                            });
                          } else {
                            await storage.write(
                                key: "token",
                                value: response.data['data']['token']);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Home();
                              }),
                            );
                            print(response.toString());
                          }
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: kPrimaryColorAccent,
                          color: kPrimaryColor,
                          elevation: 5.0,
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                // fontFamily: 'Raleway',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20.0),
                    // GestureDetector(
                    //   onTap: () async {
                    //     try {
                    //       final result = await FlutterWebAuth.authenticate(
                    //           url:
                    //               "http://20.124.13.106:8000/oauth/google/login",
                    //           callbackUrlScheme: "chakravyuh-app");
                    //       final token =
                    //           Uri.parse(result).queryParameters['jwt'];
                    //       await storage.write(key: "token", value: token);
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(builder: (context) {
                    //           return Home();
                    //         }),
                    //       );
                    //     } catch (e) {
                    //       setState(() {
                    //         error = "pls try again";
                    //       });
                    //     }
                    //   },
                    //   child: Container(
                    //     height: 50.0,
                    //     color: Colors.transparent,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color:
                    //                 MediaQuery.of(context).platformBrightness ==
                    //                         Brightness.light
                    //                     ? kDark[800]!
                    //                     : kLight,
                    //             style: BorderStyle.solid,
                    //             width: 2.0,
                    //           ),
                    //           color: Colors.transparent,
                    //           borderRadius: BorderRadius.circular(25.0)),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         // ignore: prefer_const_literals_to_create_immutables
                    //         children: [
                    //           Text(
                    //             'Login with Google',
                    //             style: TextStyle(
                    //               // // fontFamily: 'Raleway',
                    //               color: Colors.white,
                    //               // fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 10.0),
                    //             child: Image(
                    //               image: AssetImage('assets/images/google.png'),
                    //               height: 40.0,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20.0),
                    // GestureDetector(
                    //   onTap: () async {
                    //     try {
                    //       final result = await FlutterWebAuth.authenticate(
                    //           url:
                    //               "http://20.124.13.106:8000/oauth/github/login",
                    //           // 'https://chavyuh-portal.vercel.app/oauth',
                    //           callbackUrlScheme:
                    //               "https://chavyuh-portal.vercel.app/oauth");
                    //       final token =
                    //           Uri.parse(result).queryParameters['jwt'];
                    //       await storage.write(key: "token", value: token);
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(builder: (context) {
                    //           return Home();
                    //         }),
                    //       );
                    //     } catch (e) {
                    //       setState(() {
                    //         error = "pls try again";
                    //       });
                    //     }
                    //   },
                    //   child: Container(
                    //     height: 50.0,
                    //     color: Colors.transparent,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           border: Border.all(
                    //             color:
                    //                 MediaQuery.of(context).platformBrightness ==
                    //                         Brightness.light
                    //                     ? kDark[800]!
                    //                     : kLight,
                    //             style: BorderStyle.solid,
                    //             width: 2.0,
                    //           ),
                    //           color: Colors.transparent,
                    //           borderRadius: BorderRadius.circular(25.0)),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         // ignore: prefer_const_literals_to_create_immutables
                    //         children: [
                    //           Text(
                    //             'Login with Github',
                    //             style: TextStyle(
                    //               // // fontFamily: 'Raleway',
                    //               color: Colors.white,
                    //               // fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 10.0),
                    //             child: Image(
                    //               image: AssetImage('assets/images/github.png'),
                    //               height: 30.0,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async {
                        widget.func!();
                      },
                      child: Container(
                        height: 50.0,
                        color: Colors.transparent,
                        child: Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color:
                          //           MediaQuery.of(context).platformBrightness ==
                          //                   Brightness.light
                          //               ? kForeground
                          //               : kLight,
                          //       style: BorderStyle.solid,
                          //       width: 2.0,
                          //     ),
                          //     color: Colors.transparent,
                          //     borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Center(
                                child: Text(
                                  'Don\'t have an account? Register',
                                  style: TextStyle(
                                      // fontFamily: 'Raleway',
                                      // color: Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: size.width * 0.2,
                    //       vertical: kDefaultPadding * 2),
                    //   child: IntrinsicHeight(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () async {
                    //             // try {
                    //             //   final String result = await WebAuth.open(
                    //             //       context,
                    //             //       "https://localhost.benro.dev/oauth/google/login",
                    //             //       "https://chavyuh-portal.vercel.app/");
                    //             //   final Uri token = Uri.parse(result);
                    //             //   final String? accessToken =
                    //             //       token.queryParameters['jwt'];
                    //             //   print(token);
                    //             //   print("JWT token is: ");
                    //             //   print(accessToken);
                    //             //   await storage.write(
                    //             //       key: "token", value: accessToken);
                    //             //   Navigator.pushReplacement(
                    //             //     context,
                    //             //     MaterialPageRoute(builder: (context) {
                    //             //       return Home();
                    //             //     }),
                    //             //   );
                    //             // } catch (e) {
                    //             //   setState(() {
                    //             //     error = "pls try again";
                    //             //   });
                    //             // }
                    //           },
                    //           child: Container(
                    //             // height: 50.0,
                    //             decoration: BoxDecoration(
                    //               borderRadius:
                    //                   BorderRadius.circular(size.width),
                    //               color: MediaQuery.of(context)
                    //                           .platformBrightness ==
                    //                       Brightness.dark
                    //                   ? kForeground
                    //                   : kLight,
                    //             ),
                    //             // color: kDark[900],
                    //             padding: EdgeInsets.all(10.0),
                    //             child: Image(
                    //               image: AssetImage('assets/images/google.png'),
                    //               width: size.width * 0.1,
                    //             ),
                    //           ),
                    //         ),
                    //         VerticalDivider(
                    //           thickness: 3.0,
                    //         ),
                    //         GestureDetector(
                    //           onTap: () async {
                    //             // try {
                    //             //   final String result = await WebAuth.open(
                    //             //       context,
                    //             //       "https://localhost.benro.dev/oauth/github/login",
                    //             //       "https://chavyuh-portal.vercel.app/");
                    //             //   final Uri token = Uri.parse(result);
                    //             //   final String? accessToken =
                    //             //       token.queryParameters['jwt'];
                    //             //   print(token);
                    //             //   print("JWT token is: ");
                    //             //   print(accessToken);
                    //             //   await storage.write(
                    //             //       key: "token", value: accessToken);
                    //             //   Navigator.pushReplacement(
                    //             //     context,
                    //             //     MaterialPageRoute(builder: (context) {
                    //             //       return Home();
                    //             //     }),
                    //             //   );
                    //             // } catch (e) {
                    //             //   setState(() {
                    //             //     error = "pls try again";
                    //             //   });
                    //             // }
                    //           },
                    //           child: Container(
                    //             // height: 50.0,
                    //             decoration: BoxDecoration(
                    //               borderRadius:
                    //                   BorderRadius.circular(size.width),
                    //               color: MediaQuery.of(context)
                    //                           .platformBrightness ==
                    //                       Brightness.dark
                    //                   ? kForeground
                    //                   : kLight,
                    //             ),
                    //             // color: kDark[900],
                    //             padding: EdgeInsets.all(10.0),
                    //             child: Image(
                    //               image: AssetImage('assets/images/github.png'),
                    //               width: size.width * 0.1,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
