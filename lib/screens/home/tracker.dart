import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/home/home.dart';
import 'package:ecolyf_app/screens/home/qrscannerEnd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class Tracker extends StatefulWidget {
  const Tracker({ Key? key }) : super(key: key);

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {

  double lat = 51.5;
  double lng = -0.09;
  String message = "";
  bool isLoading = true;
  var storage = const FlutterSecureStorage();
  var dio = Dio();


  void checkPermission()async{
    bool _serviceEnabled;
    Location location = Location();
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Error');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Error');
      }
    }
  }

 void getLocation() async{
   print('hello');
    LocationData _locationData;
    Location location = Location();
    _locationData = await location.getLocation();
    
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        lat = currentLocation.latitude!;
      lng = currentLocation.longitude!;
      isLoading=false;
      });
    });

    // setState((){
    //   location.onLocationChanged.listen((LocationData currentLocation) {
    //   lat = _locationData.latitude!;
    //   lng = _locationData.longitude!;
    //   isLoading=false;
    // });
    // });
    print(lng);
    print(lat);
    print(_locationData);
  }

  

  @override
  void initState(){
    getLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading ?  Container() : Scaffold(
      // appBar: AppBar(
      //   title: const Text('Live location'),
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   toolbarHeight: kToolbarHeight + 20.0,
      //   foregroundColor: kDark,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.my_location_rounded),
        // foregroundColor: MediaQuery.of(context).platformBrightness ==
        //                           Brightness.light
        //                       ? kDark[900]
        //                       : Colors.white,
        foregroundColor: kPrimaryColor,
        onPressed: () {
          getLocation();
        },
      ),
      body: Stack(
        children: 
          [FlutterMap(
          options: MapOptions(
            center: LatLng(lat, lng),
            zoom: 18.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return const Text("");
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(lat, lng),
                  builder: (ctx) =>
                  Container(
                    child: Icon(
                                Icons.directions_bike_rounded,
                                color: kDark[800],
                                size: 54,
                              ),
                  ),
                ),
              ],
            ),
          ],
          ),
          Positioned(bottom: kDefaultPadding, right: kDefaultPadding*2 + 100.0, left: kDefaultPadding, child:  GestureDetector(
                      
                      onTap: () async {
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const QRScannerEnd();
                            }),
                            );
                          // var token = await storage.read(key: "token");
                          // Response response = await dio.post(
                          //   'https://api-ecolyf-alt.herokuapp.com/home/end',
                          //   options: Options(headers: {
                          //     HttpHeaders.contentTypeHeader: "application/json",
                          //     HttpHeaders.authorizationHeader:"Bearer " + token!,

                          //   }),
                          //   // data: jsonEncode(value),
                          //   data: {

                          //   },
                          // );
                          // if (response.data['status'] != true) {
                          //   setState(() {
                          //     message = response.data['message'];
                          //   });
                          // } else {
                          //   print(response.data);
                          //   // Navigator.of(context).pop();
                          //    Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(builder: (context) {
                          //     return const Home();
                          //   }),
                          //   );
                          //   // print(response.toString());
                          // }
                        
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            
                              borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Material(
                          
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: kPrimaryColorAccent,
                          color: kPrimaryColor,
                          elevation: 5.0,
                          child: const Center(
                            child: Text(
                              'END RIDE',
                              style: TextStyle(
                                // fontFamily: 'Raleway',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),),
        ],
      ),
    );
  }
}