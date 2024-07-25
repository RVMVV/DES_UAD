import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/sdm/sdm_dosen_jabfung_model.dart';
import 'dosen_jabfung_item.dart';

class JabfungDosen extends StatefulWidget {
  String jabfungkode;
  String jabfungNama;

  JabfungDosen({Key? key, required this.jabfungkode, required this.jabfungNama})
      : super(key: key);

  @override
  State<JabfungDosen> createState() =>
      _JabfungDosenState(this.jabfungkode, this.jabfungNama);
}

class _JabfungDosenState extends State<JabfungDosen> {
  String jabfungkode;
  String jabfungNama;
  _JabfungDosenState(this.jabfungkode, this.jabfungNama);

  @override
  Widget build(BuildContext context) {
    final sdmCubits = context.read<SdmCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          jabfungNama,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        titleSpacing: 15.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SdmCubit, SdmState>(
            bloc: sdmCubits..getDosenJabfung(jabfungkode),
            builder: (context, state) {
              if (state is DosenJabfungLoaded) {
                List<Dosen> dosens = state.datas.data;
                return Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.white,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var dtDosen = dosens[index];
                        int no = index + 1;
                        return DosenJabfungItem(
                          no: no.toString(),
                          prodi: dtDosen.prodi,
                          fakultas: dtDosen.fakultas,
                          dosen: dtDosen.dosen,
                        );
                      }),
                );
              }
              return Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
