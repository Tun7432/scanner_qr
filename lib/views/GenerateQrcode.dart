import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrcode extends StatefulWidget {
  const GenerateQrcode({super.key});

  @override
  State<GenerateQrcode> createState() => _GenerateQrcodeState();
}

class _GenerateQrcodeState extends State<GenerateQrcode> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate QR Code")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Generate QRCode",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: QrImageView(
                      data: data,
                      backgroundColor: Colors.white,
                      size: 220,
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          data = Encrypt(value);
                        });
                      },
                      decoration: InputDecoration(hintText: "Input Data"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String Encrypt(String value) {
  final level1 = encodeROT13(value);
  final level2 = encodeDecimalToBinary(level1);
  final output = "$level2";

  print("Input = $value");
  print("Level 1, ROT-13 = $level1");
  print("Level 2, DTB = $level2");
  print("Output =  $output");

  return output;
}

String encodeROT13(String input) {
  return input.runes.map((rune) {
    if ((rune >= 65 && rune <= 77) || (rune >= 97 && rune <= 109)) {
      // Rotate by 13 places for uppercase and lowercase letters
      return String.fromCharCode(rune + 13);
    } else if ((rune >= 78 && rune <= 90) || (rune >= 110 && rune <= 122)) {
      // Wrap around for letters beyond 'M' or 'm'
      return String.fromCharCode(rune - 13);
    } else {
      // Non-alphabet characters
      return String.fromCharCode(rune);
    }
  }).join();
}

String encodeDecimalToBinary(String input) {
  return input.runes.map((rune) {
    if (rune >= 48 && rune <= 57) {
      // Digits
      final binaryString =
          int.parse(String.fromCharCode(rune)).toRadixString(2);
      return binaryString.padLeft(4, '0');
    } else {
      // Non-digit characters
      return String.fromCharCode(rune);
    }
  }).join();
}
