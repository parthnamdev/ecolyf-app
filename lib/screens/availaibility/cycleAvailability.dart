import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CycleAvailability extends StatefulWidget {
  const CycleAvailability(
      {required this.available, required this.standName, required this.cycles});
  final String standName;
  final int available;
  final Map cycles;
  @override
  State<CycleAvailability> createState() => _CycleAvailabilityState();
}

class _CycleAvailabilityState extends State<CycleAvailability> {
  // var storage = FlutterSecureStorage();
  // var dio = Dio();
  // bool isLoading = true;
  // Map user = {};
  // Map stats = {};
  // Future<void> getStats() async {
  //   var token = await storage.read(key: "token");
  //   Response response = await dio.get(
  //     "https://api-ecolyf-alt.herokuapp.com/home/getUser",
  //     options: Options(headers: {
  //       HttpHeaders.contentTypeHeader: "application/json",
  //       HttpHeaders.authorizationHeader: "Bearer " + token!
  //     }),
  //   );
  //   // print(response.data);
  //   if (response.data['status'] == true) {
  //     user = response.data['data']['user'];
  //     print(user);
  //     Response response1 = await dio.get(
  //       "https://api-ecolyf-alt.herokuapp.com/home/getStats",
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //         HttpHeaders.authorizationHeader: "Bearer " + token
  //       }),
  //     );
  //     if (response1.data['status'] == true) {
  //       stats = response1.data['data'];
  //       print(stats);
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     user = response.data['data'];
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  int selectedType = 0;
  String cycleType = "Geared";
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();
  var dio = Dio();
  String error = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getStats();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
   
    void changeCycleType(int index, String flav) {
      setState(() {
        cycleType = flav;
        selectedType = index;
      });
      print(selectedType);
    }

    Widget cycleRadio(int index, String flav, String price, int quantity, String image) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child:
              // OutlinedButton(
              //   onPressed: () => changeFlavour(index, flav),
              //   child: Text(flav),
              //   style: OutlinedButton.styleFrom(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              //     padding: EdgeInsets.all(15.0),
              //     side: BorderSide(
              //       color: selectedFlavour == index ? kPrimaryColor : kDark,
              //       width: selectedFlavour == index ? 2 : 1,
              //     ),
              //     backgroundColor: selectedFlavour == index ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
              //   ),

              // ),
              GestureDetector(
            onTap: () => changeCycleType(index, flav),
            child: Container(
              padding: EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kDark[900],
                border: Border.all(
                    color: selectedType == index ? kPrimaryColor : kDark, width: selectedType == index ? 2 : 1),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Image(
                      image: AssetImage(image),
                      fit: BoxFit.contain,
                      width: size.width * 0.4, ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flav,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        price,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        quantity.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        // title: Text('Rides Available'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 20.0,
        foregroundColor: kDark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Availability at',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: size.width * 0.6,
                        child: Text(
                          widget.standName,
                          style: TextStyle(
                            fontSize: 60,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.pedal_bike_rounded, size: 60, color: kDark)
                ],
              ),
              SizedBox(height:25.0,),
              cycleRadio(0, "Geared", '8 km/hr', widget.cycles['Geared'], "assets/images/type1.png"),
              cycleRadio(1, "Regular", '7 km/hr', widget.cycles['Regular'], "assets/images/type2.png"),
              cycleRadio(2, "Diva", '7 km/hr', widget.cycles['Diva'], "assets/images/type3.png"),
               SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            var token = await storage.read(key: "token");
                                
                            Response response = await dio.post(
                              'https://api-ecolyf-alt.herokuapp.com/home/prebook',
                              options: Options(headers: {
                                HttpHeaders.contentTypeHeader: "application/json",
                                HttpHeaders.authorizationHeader:
                                        "Bearer " + token!
                              }),
                              // data: jsonEncode(value),
                              data: {"cycleType": cycleType, "stand": widget.standName},
                            );
                            if (response.data['status'] != true) {
                              setState(() {
                                error = response.data['message'];
                              });
                            } else {
                              Navigator.of(context).pop();
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
                                'PRE-BOOK',
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
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
