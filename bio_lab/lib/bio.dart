import 'package:bio_lab/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';

class MyBio extends StatefulWidget {
  const MyBio({super.key});

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biometric Authentication"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_supportState)
            const Text("This Device is supported BioAuthentication")
          else
            const Text("This Device is not supported BioAuthentication"),
          const Divider(height: 100),
          ElevatedButton(
              onPressed: () {
                _getAvaiableBiometics();
              },
              child: Text("Get Device")),
          const Divider(height: 100),
          ElevatedButton(
              onPressed: () {
                _authenticate();
              },
              child: Text("Authenticated"))
        ],
      ),
    );
  }

  void _getAvaiableBiometics() async {
    List<BiometricType> availableBiometics =
        await auth.getAvailableBiometrics();

    print("List of availableBioMetrics $availableBiometics");
    if (!mounted) {
      return;
    }
  }

  void _authenticate() async {
    try {
      bool authenticate = await auth.authenticate(
        localizedReason: "Authentication Demo",
        authMessages: [
          AndroidAuthMessages(
            signInTitle: "กรุณายืนยันตัวตนด้วยข้อมูล BIO",
            biometricNotRecognized: "ไม่รู้จัก",
            biometricSuccess: "การยืนยันถูกต้อง",
            cancelButton: "ไม่ล่ะ ขอบคุณ",
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      // แสดง DialogBox เมื่อยืนยันตัวตนผิดพลาด
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Authentication Result"),
            content: Text(authenticate
                ? "การยืนยันตัวตนถูกต้อง"
                : "การยืนยันตัวตนผิดพลาด"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // ปิด DialogBox
                  if (authenticate) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(title: "Bio Access"),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.lockedOut) {
        print("ผิดพลาดเกินข้อกำหนด ระะ Lock ชั่วคราว");
      } else {
        print(e);
      }
    }
  }
}
