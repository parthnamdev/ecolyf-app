// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Register extends StatefulWidget {
  final Function? func;
  // ignore: use_key_in_widget_constructors
  const Register({this.func});

  @override
  _RegisterState createState() => _RegisterState();
}

//CHANGE KRVANU CHE AYA
class _RegisterState extends State<Register> {
  // bool uniqueUsername = true;
  // bool uniqueEmail = true;
  var dio = Dio();
  var storage = FlutterSecureStorage();
  // Future<void> checkUsername(username) async {
  //   // var dio = Dio();
  //   try {
  //     Response response = await dio
  //         .get("http://api-tassie.herokuapp.com/user/username/" + username);
  //     // var res = jsonDecode(response.toString());

  //     // if(response)
  //     // return res.status;

  //     uniqueUsername = response.data['status'];
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       uniqueUsername = e.response!.data['status'];
  //     }
  //   }
  // }

  // Future<void> checkEmail(email) async {
  //   // var dio = Dio();
  //   try {
  //     Response response = await dio
  //         .get("http://api-tassie.herokuapp.com/user/checkEmail/" + email);
  //     // var res = jsonDecode(response.toString());

  //     // if(response)
  //     // return res.status;

  //     uniqueEmail = response.data['status'];
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       uniqueEmail = e.response!.data['status'];
  //     }
  //   }
  // }

  String password = "";
  String email = "";
  String error = "";
  String name = "";
  String username = "";
  String number = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Get started!'),
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
                      //     labelText: 'NAME',
                      //     labelStyle: TextStyle(
                      //       // fontFamily: 'Raleway',
                      //       fontSize: 12.0,
                      //       // color: kDark[800]!.withOpacity(0.5),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryColor))),
                      decoration: InputDecoration(
                        labelText: 'NAME',
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
                        name = value;
                      },
                      validator: (val) =>
                          val!.length < 2 ? 'Enter valid name' : null,
                    ),
                    SizedBox(height: 20.0),
                    // TextFormField(
                    //   // decoration: InputDecoration(
                    //   //     labelText: 'USERNAME',
                    //   //     labelStyle: TextStyle(
                    //   //       // fontFamily: 'Raleway',
                    //   //       fontSize: 12.0,
                    //   //       // color: kDark[800]!.withOpacity(0.5),
                    //   //     ),
                    //   //     focusedBorder: UnderlineInputBorder(
                    //   //         borderSide: BorderSide(color: kPrimaryColor))),
                    //   decoration: InputDecoration(
                    //     labelText: 'USERNAME',
                    //     labelStyle: TextStyle(
                    //       // fontFamily: 'Raleway',
                    //       fontSize: 16.0,
                    //       color: MediaQuery.of(context).platformBrightness ==
                    //               Brightness.dark
                    //           ? kPrimaryColor
                    //           : kDark[900],
                    //     ),
                    //     contentPadding: EdgeInsets.symmetric(
                    //         horizontal: 25.0, vertical: kDefaultPadding),
                    //     // floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color:
                    //               MediaQuery.of(context).platformBrightness ==
                    //                       Brightness.dark
                    //                   ? kPrimaryColor
                    //                   : kDark[900]!),
                    //       borderRadius: BorderRadius.circular(15.0),
                    //     ),
                    //   ),
                    //   onChanged: (value) async {
                    //     username = value;
                    //     // if (value.length > 4) {
                    //     //   await checkUsername(value);
                    //     // }
                    //   },
                    //   validator: (val) {
                    //     if (!RegExp(r"^(?=[a-zA-Z0-9._]{5,32}$)")
                    //         .hasMatch(val!)) {
                    //       return 'Please enter a valid Username';
                    //     }
                    //     // checkUsername(val);
                    //     // if (!uniqueUsername) {
                    //     //   return "Username already exists";
                    //     // }
                    //     //aya pan
                    //     // checkUsername(val);
                    //     return null;
                    //   },
                    // ),
                    // SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      // decoration: InputDecoration(
                      //     labelText: 'USERNAME',
                      //     labelStyle: TextStyle(
                      //       // fontFamily: 'Raleway',
                      //       fontSize: 12.0,
                      //       // color: kDark[800]!.withOpacity(0.5),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryColor))),
                      decoration: InputDecoration(
                        labelText: 'NUMBER',
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
                      onChanged: (value) async {
                        number = value.toString();
                        // if (value.length > 4) {
                        //   await checkUsername(value);
                        // }
                      },
                      validator: (val) {
                        if (!RegExp(r"^[6-9]\d{9}$").hasMatch(val!)) {
                          return 'Please enter a valid Username';
                        }
                        // checkUsername(val);
                        // if (!uniqueUsername) {
                        //   return "Username already exists";
                        // }
                        //aya pan
                        // checkUsername(val);
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      // decoration: InputDecoration(
                      //     labelText: 'EMAIL',
                      //     labelStyle: TextStyle(
                      //       // fontFamily: 'Raleway',
                      //       fontSize: 12.0,
                      //       // color: kDark[800]!.withOpacity(0.5),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryColor))),
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
                      onChanged: (value) async {
                        email = value;
                        // if (value.contains('@') && value.length > 8) {
                        //   await checkEmail(value);
                        // }
                      },
                      validator: (val) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)) {
                          return 'Please enter a valid Email';
                        }
                        // if (!uniqueEmail) {
                        //   return "Email already exists";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      // decoration: InputDecoration(
                      //     labelText: 'PASSWORD',
                      //     labelStyle: TextStyle(
                      //       // fontFamily: 'Raleway',
                      //       fontSize: 12.0,
                      //       // color: kDark[800]!.withOpacity(0.5),
                      //     ),
                      //     focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: kPrimaryColor))),
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
                      validator: (val) => val!.length < 7
                          ? 'Enter password 7+ characters long'
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
                      onTap: () async {
                        // if (_formKey.currentState!.validate()) {
                        //   dynamic result =
                        //       await _auth.registerWithEmailAndPasword(
                        //           email, password, name);
                        //   if (result == null) {
                        //     if (this.mounted) {
                        //       setState(() {
                        //         error = "Something went wrong";
                        //       });
                        //     }
                        //   }
                        // }
                        if (_formKey.currentState!.validate()) {
                          // final response = await dio.post(
                          //   "https://api-tassie.herokuapp.com/user/login/",
                          //   options: Options(headers: {
                          //     HttpHeaders.contentTypeHeader: "application/json",
                          //   }),
                          //   // data: jsonEncode(value),
                          //   data: email != ""
                          //       ? {"email": email, "password": password}
                          //       : {"username": username, "password": password},
                          // );
                          // print(response.toString());
                          try {
                            Response response = await dio
                                .post('https://api-ecolyf-alt.herokuapp.com/user/register',
                                    // "http://10.0.2.2:3000/user/",
                                    options: Options(headers: {
                                      HttpHeaders.contentTypeHeader:
                                          "application/json",
                                    }),
                                    data: {
                                  "name": name,
                                  "number": number,
                                  "email": email,
                                  "password": password,
                                });
                            if (response.data['status'] != true) {
                              print(response.data);
                              setState(() {
                                error = response.data['errors'].join(', ');
                              });
                            } else {
                              print(response.data);
                              await storage.write(
                                  key: "token",
                                  value: response.data['data']['token']);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Home();
                                }),
                              );
                            }
                          } on DioError catch (e) {
                            // if (e.response != null) {
                            //   var errorMessage = e.response!.data;
                            //   print(errorMessage);
                            // }
                            print(e);
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
                              'REGISTER',
                              style: TextStyle(
                                // fontFamily: 'Raleway',
                                color: kLight,
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
                    //               height: 40.0,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        widget.func!();
                      },
                      child: Container(
                        height: 50.0,
                        color: Colors.transparent,
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color:
                          //         MediaQuery.of(context).platformBrightness ==
                          //                 Brightness.light
                          //             ? kForeground
                          //             : kLight,
                          //     style: BorderStyle.solid,
                          //     width: 2.0,
                          //   ),
                          //   color: Colors.transparent,
                          //   borderRadius: BorderRadius.circular(25.0),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Center(
                                child: Text(
                                  'Already have an account? Sign In',
                                  style: TextStyle(
                                      // fontFamily: 'Raleway',
                                      // color: kPrimaryColorAccent,
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
                    //             //   final result = await FlutterWebAuth.authenticate(
                    //             //       url:
                    //             //           "http://20.124.13.106:8000/oauth/google/login",
                    //             //       callbackUrlScheme: "chakravyuh-app");
                    //             //   final token =
                    //             //       Uri.parse(result).queryParameters['jwt'];
                    //             //   await storage.write(
                    //             //       key: "token", value: token);
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
                    //               border: Border.all(
                    //                 color: kPrimaryColor,
                    //                 width: 0.5,
                    //               ),
                    //               // boxShadow: [
                    //               //   BoxShadow(
                    //               //     color: kPrimaryColorAccent,
                    //               //     offset: const Offset(
                    //               //       5.0,
                    //               //       5.0,
                    //               //     ),
                    //               //     blurRadius: 10.0,
                    //               //     spreadRadius: 20.0,
                    //               //   ), //BoxShadow
                    //               //   BoxShadow(
                    //               //     color: Colors.white,
                    //               //     offset: const Offset(0.0, 0.0),
                    //               //     blurRadius: 0.0,
                    //               //     spreadRadius: 0.0,
                    //               //   ), //BoxShadow
                    //               // ],
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
                    //             //   final result =
                    //             //       await FlutterWebAuth.authenticate(
                    //             //           url:
                    //             //               "http://20.124.13.106:8000/oauth/github/login",
                    //             //           // 'https://chavyuh-portal.vercel.app/oauth',
                    //             //           callbackUrlScheme:
                    //             //               "https://chavyuh-portal.vercel.app/oauth");
                    //             //   final token =
                    //             //       Uri.parse(result).queryParameters['jwt'];
                    //             //   await storage.write(
                    //             //       key: "token", value: token);
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
                    //               border: Border.all(
                    //                 color: kPrimaryColor,
                    //                 width: 0.5,
                    //               ),
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
