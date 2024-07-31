import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MahasiswaAsingWebv extends StatefulWidget {
  const MahasiswaAsingWebv({super.key});

  @override
  State<MahasiswaAsingWebv> createState() => _MahasiswaAsingWebvState();
}

class _MahasiswaAsingWebvState extends State<MahasiswaAsingWebv> {
  @override
  Widget build(BuildContext context) {
    // WebViewController controller;

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..loadRequest(Uri.parse('https://museum.uad.ac.id/testing/index2.php')
      ..loadRequest(Uri.parse(
          'https://apexcharts.com/javascript-chart-demos/line-charts/data-labels'));

    return Container(
      height: 300,
      child: WebViewWidget(controller: controller),
    );
  }
}
