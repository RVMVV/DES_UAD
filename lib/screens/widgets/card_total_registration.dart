import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant_finals.dart';
import '../../cubit/akademik_cubit.dart';
import 'base_container.dart';
import 'chart_total_registrasi.dart';

class CardTotalRegistration extends StatelessWidget {
  const CardTotalRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final akademikCubit = context.read<AkademikCubit>();
    return BaseContainer(
        border: Border.all(color: kWhite, width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F4E55).withOpacity(.1),
            blurRadius: 26,
            offset: const Offset(0, 16),
          )
        ],
        color: kBlue,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: BlocBuilder<AkademikCubit, AkademikState>(
            bloc: akademikCubit..getDataPMB(),
            buildWhen: (previous, current) => current is DataPMBState,
            builder: (context, state) {
              if (state is DataPMBLoaded) {
                // print(state.tren);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Registrasi',
                          style: Styles.kPublicSemiBoldBodyOne
                              .copyWith(color: kWhite),
                        ),
                        Row(
                          children: [
                            Text(
                              'TA ' + state.data.tahun,
                              style: Styles.kPublicRegularBodyThree
                                  .copyWith(color: kWhite),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      state.data.totalRegistrasi,
                      style: Styles.kPublicSemiBoldHeadingTwo
                          .copyWith(color: kWhite),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: ChartTotalRegistrasi(trens: state.tren),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Registrasi',
                        style: Styles.kPublicSemiBoldBodyOne
                            .copyWith(color: kWhite),
                      ),
                      Row(
                        children: [
                          Text(
                            'TA -',
                            style: Styles.kPublicRegularBodyThree
                                .copyWith(color: kWhite),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
                            ),
                          ),
                          Text(
                            '',
                            style: Styles.kPublicRegularBodyThree
                                .copyWith(color: kWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '-',
                    style: Styles.kPublicSemiBoldHeadingTwo
                        .copyWith(color: kWhite),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    // child: const ChartTotalRegistrasi(),
                  ),
                ],
              );
            }));
  }
}
