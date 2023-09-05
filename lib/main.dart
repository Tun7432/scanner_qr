import 'package:flutter/material.dart';
import 'QRCodeReaderPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QRCodeReaderPage(),
    );
  }
}
