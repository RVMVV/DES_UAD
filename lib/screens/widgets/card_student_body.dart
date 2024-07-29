import '../../cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant_finals.dart';
import 'base_container.dart';
import 'big_card_title.dart';
import 'student_status.dart';

class CardStudentBody extends StatelessWidget {
  const CardStudentBody({super.key});

  @override
  Widget build(BuildContext context) {
    //call cubit
    final HomeCubit homeCubit = context.read<HomeCubit>();

    return BaseContainer.styledBigCard(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit..getStudentBody(),
          buildWhen: (previous, current) => current is StudentBodyState,
          builder: (context, state) {
            if (state is StudentBodyLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kBlue,
                ),
              );
            }
            if (state is StudentBodyLoaded) {
              return Column(
                // aku tambahkan column disini
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BigCardTitle(title: 'Student Body'),
                      Text(
                        'Tahun ${state.data.tahun}',
                        style: Styles.kPublicRegularBodyThree
                            .copyWith(color: kLightGrey500),
                      ),
                    ],
                  ),
                  Text(
                    state.data.studentBody,
                    style: Styles.kPublicSemiBoldHeadingTwo
                        .copyWith(color: kGrey900),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
        kGap24,
        BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit..getStudentStatus(),
          buildWhen: (previous, current) => current is StudentStatusState,
          builder: (context, state) {
            if (state is AkademikStudentStatusLoading) {
              return const Center();
            }
            if (state is AkademikStudentStatusLoaded) {
              String active = state.data.aktif;
              String onLeave = state.data.cuti;
              String inactive = state.data.nonAktif;

              double finalActive = double.parse(active);
              double finalOnLeave = double.parse(onLeave);
              double finalInactive = double.parse(inactive);
              double total = finalActive + finalOnLeave + finalInactive;

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: (finalActive / total * 100).round(),
                        child: Container(
                          height: 20,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(4),
                            ),
                            color: kLightBlue,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: (finalOnLeave / total * 100).round(),
                        child: Container(
                          height: 20,
                          color: kYellow,
                        ),
                      ),
                      Expanded(
                        flex: (finalInactive / total * 100).round(),
                        child: Container(
                          height: 20,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(4),
                            ),
                            color: kPink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  kGap24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StudentStatus(
                        status: 'Aktif',
                        value: active,
                        color: kLightBlue,
                      ),
                      StudentStatus(
                        status: 'Cuti',
                        value: onLeave,
                        color: kYellow,
                      ),
                      StudentStatus(
                        status: 'Non Aktif',
                        value: inactive,
                        color: kPink,
                      ),
                    ],
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}



































//temporary
// class CardStudentBody extends StatelessWidget {
//   const CardStudentBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //call cubit
//     final HomeCubit cubit = context.read<HomeCubit>();

//     // temporary chart
//     double total = 29800;
//     double active = 24750;
//     double onLeave = 2430;
//     double inactive = 2620;

//     return BaseContainer.styledBigCard(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const BigCardTitle(title: 'Student Body'),
//             Text(
//               'TA 2023/2024',
//               style: Styles.kPublicRegularBodyThree
//                   .copyWith(color: kLightGrey500),
//             ),
//           ],
//         ),
//         Text(
//           '29.800',
//           style: Styles.kPublicSemiBoldHeadingTwo
//               .copyWith(color: kGrey900),
//         ),
//         kGap24,
//         Row(
//           children: [
//             Expanded(
//               flex: (active / total * 100).round(),
//               child: Container(
//                 height: 20,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.horizontal(
//                     left: Radius.circular(4),
//                   ),
//                   color: kLightBlue,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: (onLeave / total * 100).round(),
//               child: Container(
//                 height: 20,
//                 color: kYellow,
//               ),
//             ),
//             Expanded(
//               flex: (inactive / total * 100).round(),
//               child: Container(
//                 height: 20,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.horizontal(
//                     right: Radius.circular(4),
//                   ),
//                   color: kPink,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         kGap24,
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children:  [
//             StudentStatus(
//               status: 'Aktif',
//               value: '24.750',
//               color: kLightBlue,
//             ),
//             StudentStatus(
//               status: 'Cuti',
//               value: '2.430',
//               color: kYellow,
//             ),
//             StudentStatus(
//               status: 'Non Aktif',
//               value: '2.620',
//               color: kPink,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
