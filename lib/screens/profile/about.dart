import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/availaibility/cycleAvailability.dart';
import 'package:ecolyf_app/screens/home/qrscanner.dart';
import 'package:ecolyf_app/screens/home/stand_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final TextEditingController _standController = TextEditingController();
    // String stand = "";
    // var storage = FlutterSecureStorage();
    // var dio = Dio();
    // final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('About Ecolyf'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 20.0,
        foregroundColor: kDark,
      ),
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Container(
              // padding: const EdgeInsets.all(kDefaultPadding),
              width: size.width * 0.6,
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Lottie.asset('assets/images/bike0.json', fit: BoxFit.cover),
                  Text(
                    'Ecolyf',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Greeningly affordable rides!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.all(kDefaultPadding),
              width: size.width * 0.7,
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Lottie.asset('assets/images/eco.json', fit: BoxFit.cover),
                  Text(
                    'Go green!',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Contribute to renewable energy! \nDynamo equipped cycles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.all(kDefaultPadding),
              width: size.width * 0.6,
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Lottie.asset('assets/images/bike.json', fit: BoxFit.cover),
                  Text(
                    'Ride on the go!',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Find nearby stand \nand book your ride at ease!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 80.0),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.all(kDefaultPadding),
              width: size.width * 0.4,
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Lottie.asset('assets/images/discount.json', fit: BoxFit.cover),
                  Text(
                    'Get discounts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'More you travel\n More you earn points',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  
                ],
              ),
            ),
        ],
      ),
          )),
    );
  }
}
