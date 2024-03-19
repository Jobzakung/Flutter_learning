//แก้ MainActivity.kt , AndroidManifest.xml , build.gradle
//เปิด Terminal ใช้คำสั่ง flutter pub add local_auth
//เขียนโค้ดเสร็จกด 3 ปุ่ม => Fingerprint
//เข้า setting ในมือถือ => Security => fingerprint เพิ่ม fingerpint แล้วกดค้างที่ Touch Sensor
//กดปุ่ม Authen ที่โปรเกรมแล้วกด Touch Sensor

//การบ้าน
//เพิ่มปุ่ม Logout ในหน้า MyHomePage
//ในกรณียืนยันตัวตนผิดพลาดเกิดข้อกำหนดให้แสดงเป็นกล่องข้อความเตือน
//MyHomePage ปรับกระบวนการให้รองรับการเพิ่มและลดค่าแบบเก็บค่าเดิมไว้แม้ปิดแอพ
import 'package:bio_lab/bio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const MyBio(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyBio()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                _logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 16), // ระยะห่างระหว่างปุ่ม
        ],
      ),
    );
  }
}
