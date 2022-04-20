import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Rides extends StatefulWidget {
  const Rides({Key? key}) : super(key: key);

  @override
  State<Rides> createState() => _RidesState();
}

class _RidesState extends State<Rides> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  List upcoming = [];
  List current = [];
  List finished = [];
  var storage = FlutterSecureStorage();
  var dio = Dio();
  bool isLoading = true;

  Future<void> getRides() async {
    var token = await storage.read(key: "token");
    Response response = await dio.get(
      "https://api-ecolyf-alt.herokuapp.com/home/getRides",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token!
      }),
    );
    // print(response.data);
    if (response.data['status'] == true) {
      upcoming.addAll(response.data['data']['upcoming']);
      current.addAll(response.data['data']['current']);
      finished.addAll(response.data['data']['finished']);

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshPage() async{
    setState(() {
      List upcoming = [];
      List current = [];
      List finished = [];
      isLoading = true;
      getRides();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRides();
  }
  Widget createHeading(String text) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 32,
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget createCard(Map ride) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(kDefaultPadding),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ?kDark[900] : kLight,
            borderRadius: BorderRadius.circular(15.0),
      ),
      child: Table(
        // textDirection: TextDirection.rtl,
        // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        // border:TableBorder.all(width: 2.0,color: Colors.red),
        // defaultColumnWidth: IntrinsicColumnWidth(),
        children: [
          TableRow(children: [
            Text(
              "ID",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['uuid']),
          ]),
          TableRow(children: [
            Text(
              "User ID",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['userUuid']),
          ]),
          TableRow(children: [
            Text(
              "Cycle UUID",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['cycleUuid']['uuid']),
          ]),
          TableRow(children: [
            Text(
              "Cycle Type",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['cycleUuid']['cycleType']),
          ]),
          TableRow(children: [
            Text(
              "Distance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['distance'].toString()),
          ]),
          TableRow(children: [
            Text(
              "Timestamp",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['time']),
          ]),
          TableRow(children: [
            Text(
              "From stand",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['from']),
          ]),
          TableRow(children: [
            Text(
              "To stand",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(ride['to']),
          ]),
        ],
      ),
    );
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
        title: Text('Your Rides'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 20.0,
        foregroundColor: kDark,
            ),
            body: RefreshIndicator(
              onRefresh: _refreshPage,
              child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                createHeading('Upcoming'),
                if(upcoming.isNotEmpty) ...[
                  for (int i=0; i<upcoming.length; i++) ... [
                  createCard(upcoming[i]),
                  ]
                ] else ... [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Center(
                      child: Text(
                "No rides",
                style: TextStyle(fontSize: 18),
              ),
                    ),
                  ),
                ],
                SizedBox(height: 30.0),
                createHeading('Current'),
                if(current.isNotEmpty) ...[
                  for (int i=0; i<current.length; i++) ... [
                  createCard(current[i]),
                  ]
                ] else ... [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Center(
                      child: Text(
                "No rides",
                style: TextStyle(fontSize: 18),
              ),
                    ),
                  ),
                ],
                SizedBox(height: 30.0),
                createHeading('Finished'),
                if(finished.isNotEmpty) ...[
                  for (int i=0; i<finished.length; i++) ... [
                  createCard(finished[i]),
                  ]
                ] else ... [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Center(
                      child: Text(
                "No rides",
                style: TextStyle(fontSize: 18),
              ),
                    ),
                  ),
                ],
                
              ],
                      ),
                    ),
              ),
            ),
          );
  }
}
