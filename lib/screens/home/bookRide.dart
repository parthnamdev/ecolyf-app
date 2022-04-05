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

class Book extends StatefulWidget {
  const Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _standController = TextEditingController();
    String stand = "";
    var storage = FlutterSecureStorage();
    var dio = Dio();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s Go!'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 20.0,
        foregroundColor: kDark,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: Container(
              height: size.height * 0.8,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: size.height * 0.01),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          QRScanner()),
                                );
                        },
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                "| Tap to book your ride ".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kDark,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 6,
                              startAngle: -90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.clockwise,
                            ),
                            TextItem(
                              text: Text(
                                "Tap to book your ride |".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kDark,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 6,
                              startAngle: 90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.anticlockwise,
                            ),
                          ],
                          radius: 120,
                          position: CircularTextPosition.inside,
                          // backgroundPaint: Paint()..color = Colors.grey.shade200,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(kDefaultPadding * 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.height),
                            color: MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? kDark[900]
                                : kLight,
                            boxShadow: [
                              BoxShadow(
                                // color: Color(0xFF000000).withAlpha(60),
                                color: kPrimaryColor,
                                blurRadius: 10.0,
                                spreadRadius: 7.0,
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                              ),
                            ]),
                        child: Icon(
                          Icons.directions_bike_rounded,
                          size: 64,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TypeAheadFormField<String?>(
                                // direction: AxisDirection.up,
                                autoFlipDirection: true,
                                suggestionsCallback: StandData.getSuggestions,
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _standController,
                                  onChanged: (v) => stand = v,
                                  decoration: InputDecoration(
                                    labelText: 'Search Availability',
                                    labelStyle: TextStyle(
                                      // fontFamily: 'Raleway',
                                      fontSize: 16.0,
                                      color: MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                          ? kPrimaryColor
                                          : kDark[900],
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 25.0,
                                        vertical: kDefaultPadding),
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MediaQuery.of(context)
                                                      .platformBrightness ==
                                                  Brightness.dark
                                              ? kPrimaryColor
                                              : kDark[900]!),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, String? suggestion) =>
                                    ListTile(
                                  title: Text(suggestion!),
                                ),
                                onSuggestionSelected: (String? v) {
                                  // setState(() {
                                  _standController.text = v!;
                                  stand = v;
                                  // print(_ingredientController.text);
                                  // });
                                },
                                validator: (v) {
                                  if (v!.trim().isEmpty)
                                    return 'Please enter something';
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          // IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded),),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                var token = await storage.read(key: "token");
                                // print(stand);
                                String standName = stand.split(", ")[1].trim();
                                // print('1');
                                Response response = await dio.get(
                                  "http://10.0.2.2:5000/home/getCycleData/" +
                                      standName,
                                  options: Options(headers: {
                                    HttpHeaders.contentTypeHeader:
                                        "application/json",
                                    HttpHeaders.authorizationHeader:
                                        "Bearer " + token!
                                  }),
                                );
                                print('2');
                                print(response.data);
                                if(response.data['status'] == true) {
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CycleAvailability(available: response.data['data']['available'], standName: response.data['data']['stand'], cycles: response.data['data']['cycles'])),
                                );
                                }
                                
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(builder: (context) {
                                //     return Wrapper();
                                //   }),
                                // );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: kDark),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Icon(Icons.search_rounded,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
              ],
            ),
          ),
          Container(
            // padding: const EdgeInsets.all(kDefaultPadding),
            width: size.width * 0.6,
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
      )),
    );
  }
}
