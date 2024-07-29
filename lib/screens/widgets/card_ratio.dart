import 'base_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constant_finals.dart';

class CardRatio extends StatelessWidget {
  final String title;
  final String total;
  final String ratio;
  final String svgIcon;
  final String seeAll;
  const CardRatio({
    super.key,
    required this.title,
    required this.total,
    required this.ratio,
    required this.svgIcon,
    this.seeAll = '',
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: kLightGrey100,
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: SvgPicture.asset(svgIcon),
                          ),
                        ),
                        kGap8,
                        Text(
                          title,
                          style: Styles.kPublicSemiBoldBodyOne.copyWith(
                            color: kGrey900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  seeAll,
                  style: Styles.kPublicRegularBodyThree.copyWith(
                    color: kBlue,
                  ),
                ),
              ],
            ),
            kGap16,
            Container(
              height: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kLightGrey100,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          total,
                          style: Styles.kPublicSemiBoldHeadingTwo.copyWith(
                            color: kGrey900,
                          ),
                        ),
                        Text('Total $title',
                            style: Styles.kPublicRegularBodyThree.copyWith(
                              color: kLightGrey500,
                            ))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: VerticalDivider(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ratio,
                          style: Styles.kPublicSemiBoldHeadingTwo.copyWith(
                            color: kGrey900,
                          ),
                        ),
                        Text(
                          'Rasio dengan \nMahasiswa',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: Styles.kPublicRegularBodyThree
                              .copyWith(color: kLightGrey500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
