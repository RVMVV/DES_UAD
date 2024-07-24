import 'package:des_uad/core/constant_finals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/mutu_cubit.dart';
import '../../../data/models/mutu/prodi_akreditasi.dart';
import 'akreditasi_prodi_item.dart';

class BottomModalAkreditasiProdi extends StatefulWidget {
  String akre;

  BottomModalAkreditasiProdi({Key? key, required this.akre}) : super(key: key);

  @override
  State<BottomModalAkreditasiProdi> createState() =>
      _BottomModalAkreditasiProdiState(this.akre);
}

class _BottomModalAkreditasiProdiState
    extends State<BottomModalAkreditasiProdi> {
  String akre;
  _BottomModalAkreditasiProdiState(this.akre);

  @override
  Widget build(BuildContext context) {
    final mutuCubit = context.read<MutuCubit>();
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.75,
      // color: Colors.amber,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // BottomModalContentItem(title: 'Teknologi Industri'),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Text(
              akre,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: kGrey50),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<MutuCubit, MutuState>(
              bloc: mutuCubit..getProdiByAkreditasi(),
              builder: (context, state) {
                if (state is AkreditasiProdiLoaded) {
                  List<DataProdi> prodis = state.datas.data;
                  return Container(
                    height: MediaQuery.of(context).copyWith().size.height * 0.6,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var dtProdi = prodis[index];
                          int no = index + 1;
                          return AkreditasiProdiItem(
                            no: no.toString(),
                            prodi: dtProdi.prodi,
                            fakultas: dtProdi.fakultas,
                            lembaga: dtProdi.lembagaAkred,
                            masaBerlaku: dtProdi.masaBerlaku,
                            warna: dtProdi.color,
                          );
                        }),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
