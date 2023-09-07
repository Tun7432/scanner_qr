import 'package:flutter/material.dart';
import 'package:scanner_qr/QRCodeReaderPage.dart';
import 'package:scanner_qr/views/GenerateQrcode.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                Icon(
                  Icons.qr_code,
                  size: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Scan & Generate",
                  style: TextStyle(fontSize: 20, fontFamily: 'NotoSansThai'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "QR Code",
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      FilledButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GenerateQrcode()));
                        },
                        child: Text("Gernerate QR Code"),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 8.0),
                      //   child: FilledButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => QRCodeReaderPage()));
                      //     },
                      //     child: Text("Scan QR Code"),
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QRCodeReaderPage()));
        },
        label: Icon(
          Icons.qr_code_scanner,
        ),
      ),
    );
  }
}
