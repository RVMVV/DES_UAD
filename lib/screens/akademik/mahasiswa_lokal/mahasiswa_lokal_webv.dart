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
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://museum.uad.ac.id/testing/index2.php'));
    return Container(
      height: 300,
      child: WebViewWidget(controller: controller),
    );
  }
}
