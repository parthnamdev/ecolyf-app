import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecolyf_app/constants.dart';
import 'package:ecolyf_app/screens/home/home.dart';

import 'package:ecolyf_app/screens/home/tracker.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerEnd extends StatefulWidget {
  const QRScannerEnd({ Key? key }) : super(key: key);

  @override
  State<QRScannerEnd> createState() => _QRScannerEndState();
}

class _QRScannerEndState extends State<QRScannerEnd> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;
  var storage = FlutterSecureStorage();
  var dio = Dio();
  String message = "Place QR in above square";
  bool isScanned = false;
  bool isClicked = false;

  Widget buildQrView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: size.width * 0.8, 
        borderColor: kPrimaryColor,
        borderWidth: 10,
        borderRadius: 10.0, 
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode){ 
      setState(() => this.barcode = barcode);
      setState(() => isScanned = true);
      setState(() => message = "Click to End!");
      });
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();

    if(Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR code'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight + 20.0,
        foregroundColor: kDark,
      ),
      body: Stack(
        
        children: [
          buildQrView(context),
          Positioned(bottom: size.height * 0.1, right: kDefaultPadding*2, left: kDefaultPadding*2, child:  GestureDetector(
                      
                      onTap: () async {
                        if(barcode != null && !isClicked){
                          setState(() {
                            isClicked = true;
                          });
                          print(barcode!.code);
                          var token = await storage.read(key: "token");
                          Response response = await dio.post(
                            'https://api-ecolyf-alt.herokuapp.com/home/end',
                            options: Options(headers: {
                              HttpHeaders.contentTypeHeader: "application/json",
                              HttpHeaders.authorizationHeader:"Bearer " + token!,

                            }),
                            // data: jsonEncode(value),
                            data: {"standName": barcode!.code},
                          );
                          if (response.data['status'] != true) {
                            setState(() {
                              message = response.data['message'];
                              isClicked = false;
                            });
                          } else {
                            print(response.data);
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Home();
                            }),
                            );
                            // print(response.toString());
                          }
                        } else {
                          setState(() {
                            message = "Some error occured. Please try again!";
                          });

                        }
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 2.0),
                            
                              borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Material(
                          
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: kPrimaryColorAccent,
                          color: isScanned ? kPrimaryColor : MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kDark[900]
                              : Colors.white,
                          elevation: 5.0,
                          child: Center(
                            child: isClicked ? Transform.scale(scale: 0.7, child: CircularProgressIndicator(color: kDark[900],)) :Text(
                              message,
                              style: TextStyle(
                                // fontFamily: 'Raleway',
                                color: isScanned ? Colors.white : MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? kDark
                              : kDark[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),)
        ],
      ),
    );
  }
}