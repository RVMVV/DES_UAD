import 'package:flutter/material.dart';

import '../../../core/constant_finals.dart';

class AppBarSubMenuAkademik extends StatelessWidget {
  const AppBarSubMenuAkademik({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlue,
      width: double.infinity,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              children: [
                IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kWhite,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Styles.kPublicSemiBoldHeadingFour
                        .copyWith(color: kWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
                // This empty SizedBox balances the IconButton on the left
                const SizedBox(width: 50), // Assuming IconButton width is 48
              ],
            ),
          ),
        ],
      ),
    );
  }
}
