import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class LabQR extends StatefulWidget {
  const LabQR({super.key});

  @override
  State<LabQR> createState() => _LabQRState();
}

class _LabQRState extends State<LabQR> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? image2;
  var result = "";
  int _counterCamera = 0, _counterGallery = 0, _countScan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images & QR scan"),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.amber[200],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _CounterCamera();
                    CameraCapture();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the button color to red
                    padding: EdgeInsets.all(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.white, // Set the icon color to white
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Using Camera $_counterCamera",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 24),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              image == null
                  ? const Text(
                      "image Here",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
                    )
                  : Image.file(
                      File(image!.path),
                      width: 120,
                      height: 120,
                    ),
              ElevatedButton(
                onPressed: () {
                  _CounterGallery();
                  galleryPicture();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow, // Set the button color to red
                  padding: EdgeInsets.all(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.white, // Set the icon color to white
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Using Gallery $_counterGallery",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              image2 == null
                  ? Text(
                      "image Here",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
                    )
                  : Image.file(
                      File(image2!.path),
                      width: 120,
                      height: 120,
                    ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _CountScan();
                  _scanQR();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.qr_code_2,
                      color: Colors.pink, // Set the icon color to white
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Scan QRcode $_countScan \n $result",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 24),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counterCamera = 0;
                    _counterGallery = 0;
                    _countScan = 0;
                  });
                },
                child: const Text("Reset count"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _CounterCamera() {
    setState(() {
      _counterCamera++;
    });
  }

  void _CounterGallery() {
    setState(() {
      _counterGallery++;
    });
  }

  void _CountScan() {
    setState(() {
      _countScan++;
    });
  }

  // ignore: non_constant_identifier_names
  void CameraCapture() async {
    final XFile? selectImage =
        await _picker.pickImage(source: ImageSource.camera);
    print(selectImage!.path);
    setState(() {
      image = selectImage;
    });
  }

  void galleryPicture() async {
    final XFile? selectImage =
        await _picker.pickImage(source: ImageSource.gallery);
    print(selectImage!.path);
    setState(() {
      image2 = selectImage;
    });
  }

  Future _scanQR() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
          print("Camera permission was denied");
        });
      } else {
        setState(() {
          result = "Unknow an Error $e";
          print("Unknow an Error $e");
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning";
        print("You pressed the back button before scanning");
      });
    } catch (e) {
      setState(() {
        result = "Unknown an Error $e";
        print("Unknown an Error $e");
      });
    }
  }
}
