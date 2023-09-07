import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeReaderPage extends StatefulWidget {
  const QRCodeReaderPage({super.key});

  @override
  State<QRCodeReaderPage> createState() => _QRCodeReaderPageState();
}

class _QRCodeReaderPageState extends State<QRCodeReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String? input;
  String decodedResult = "";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 12, 12, 12),
                width: 1,
              ),
            ),
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 20,
                borderLength: 50,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: (result != null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Data : ${result!.code}'),
                      SizedBox(height: 20),
                      Text('Decoded Data : ${decodeData(result!.code!)}'),
                    ],
                  )
                : Text("Scan a code"),
          ),
        ),
      ]),
    );
  }

  String decodeData(String data) {
    final decodedLevel1 = decodeBinaryToDecimal(data);
    final decodedLevel2 = decodeROT13(decodedLevel1);
    return decodedLevel2;
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        // input = result!.code!;
        decodedResult = decodeData(result!.code!);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// ฟังก์ชันอื่น ๆ เหมือนเดิม

String Decode(String inputEncode) {
  final input = inputEncode;
  final decodedLevel1 = decodeBinaryToDecimal(input);
  final decodedLevel2 = decodeROT13(decodedLevel1);

  print("Decoded Input = $input");
  print("Decoded Level 1, ROT-13 = $decodedLevel1");
  print("Decoded Level 2 = $decodedLevel2");
  print("Decoded Output = $decodedLevel2");

  return decodedLevel2;
}

String decodeROT13(String input) {
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
  }).join(); // ROT-13 is its own inverse
}

String decodeBinaryToDecimal(String input) {
  final decodedString = input.replaceAllMapped(RegExp(r'[01]{4}'), (match) {
    final decimalValue = int.parse(match.group(0)!, radix: 2);
    return decimalValue.toString();
  });
  return decodedString;
}
