import 'package:flutter/material.dart';

class BodySubMenuAkademik extends StatelessWidget {
  const BodySubMenuAkademik({
    super.key,
    required this.appBar,
    required this.children,
    // this.height = 3000,
  });

  final Widget appBar;
  final List<Widget> children;
  // final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        // height: height,
        child: Column(
          children: [
            appBar,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(children: children),
            ),
          ],
        ),
      ),
    );
  }
}
