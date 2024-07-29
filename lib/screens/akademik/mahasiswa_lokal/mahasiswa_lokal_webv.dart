import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MahasiswaLokalWebv extends StatefulWidget {
  const MahasiswaLokalWebv({super.key});

  @override
  State<MahasiswaLokalWebv> createState() => _MahasiswaLokalWebvState();
}

class _MahasiswaLokalWebvState extends State<MahasiswaLokalWebv> {
  @override
  Widget build(BuildContext context) {
    WebViewController controller;

    controller = WebViewController()
      ..loadRequest(Uri.parse(
          'https://museum.uad.ac.id/index.php/auth/Auth/testtt/d9eb71ab162db54d6f1689be0a1ed744db9b91b0'));

    return Container(
      height: 300,
      child: WebViewWidget(controller: controller),
    );
  }
}
