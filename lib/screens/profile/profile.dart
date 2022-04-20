import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/profile/about.dart';
import 'package:ecolyf_app/screens/profile/components/profilePic.dart';
import 'package:ecolyf_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  var storage = FlutterSecureStorage();
  var dio = Dio();
  bool isLoading = true;
  Map user = {};
  Map stats = {};
  Future<void> getStats() async {
    var token = await storage.read(key: "token");
    Response response = await dio.get(
      "https://api-ecolyf-alt.herokuapp.com/home/getUser",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token!
      }),
    );
    // print(response.data);
    if (response.data['status'] == true) {
      user = response.data['data']['user'];
      print(user);
      Response response1 = await dio.get(
        "https://api-ecolyf-alt.herokuapp.com/home/getStats",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token
        }),
      );
      if (response1.data['status'] == true) {
        stats = response1.data['data'];
        print(stats);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      user = response.data['data'];
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _refreshPage() async {
    setState(() {
      isLoading = true;
      getStats();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStats();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? Scaffold(
            // backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              // strokeWidth: 2.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('My Profile'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              toolbarHeight: kToolbarHeight + 20.0,
              foregroundColor: kDark,
            ),
            body: RefreshIndicator(
              onRefresh: _refreshPage,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      ProfilePic(),
                      Padding(
                        padding: EdgeInsets.all(kDefaultPadding * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  stats != {} ? stats['rides'].toString() : '0',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 44.0,
                                  ),
                                ),
                                Text('Rides'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  user != {} ? user['distance'].toString() : '0',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 44.0,
                                  ),
                                ),
                                Text('KMs'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      ListTile(
                        leading: Icon(Icons.badge_rounded),
                        title: Text(
                          user != {} ? user['name'] : 'name',
                        ),
                        tileColor: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? kDark[900]
                            : kLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        leading: Icon(Icons.numbers_rounded),
                        title: Text(
                          user != {} ? user['number'].toString() : 'number',
                        ),
                        tileColor: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? kDark[900]
                            : kLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        leading: Icon(Icons.mail_rounded),
                        title: Text(
                          user != {} ? user['email'] : 'email',
                        ),
                        tileColor: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? kDark[900]
                            : kLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                          // padding: EdgeInsets.symmetric(horizontal: 40),
            
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(20)),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => About()),
                            );
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(builder: (context) {
                            //     return Wrapper();
                            //   }),
                            // );
                          },
                          child: Text(
                            "ABOUT US",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2,
                              color: kDark,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                            OutlinedButton(
                              // padding: EdgeInsets.symmetric(horizontal: 40),
            
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(20)),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                var token = await storage.read(key: "token");
                                print('1');
                                Response response = await dio.post(
                                  "https://api-ecolyf-alt.herokuapp.com/user/logout/",
                                  options: Options(headers: {
                                    HttpHeaders.contentTypeHeader: "application/json",
                                    HttpHeaders.authorizationHeader:
                                        "Bearer " + token!
                                  }),
                                );
                                await storage.delete(key: "token");
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => Wrapper()),
                                );
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     return Wrapper();
                                //   }),
                                // );
                              },
                              child: Text(
                                "SIGN OUT",
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 2,
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                            
                            
                          ],
                        ),
                      ),
                      // SizedBox(height: 20),
                      // Center(
                      //   child: 
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
