import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/home/home.dart';
import 'package:ecolyf_app/screens/home/tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String? value;
  bool isLoading = true;
  Future<String?> check() async {
    const storage = FlutterSecureStorage();
    var x = await storage.read(key: "token");
    setState(() {
      value = x;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        // backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      );
    } else {
      if (value != null) {
        return const Home();
        // return const Tracker();

      } else {
        return const Authenticate();
      }
    }
  }
}
