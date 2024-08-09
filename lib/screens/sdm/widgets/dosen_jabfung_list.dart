import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant_finals.dart';
import '../../../cubit/sdm_cubit.dart';
import '../../../data/models/sdm/sdm_dosen_jabfung_model.dart';
import 'dosen_jabfung_item.dart';

//sementara di nonaktifkan dulu
// class JabfungDosen extends StatefulWidget {
//   String jabfungkode;
//   String jabfungNama;

//   JabfungDosen({Key? key, required this.jabfungkode, required this.jabfungNama})
//       : super(key: key);

//   @override
//   State<JabfungDosen> createState() =>
//       _JabfungDosenState(this.jabfungkode, this.jabfungNama);
// }

// class _JabfungDosenState extends State<JabfungDosen> {
//   String jabfungkode;
//   String jabfungNama;
//   _JabfungDosenState(this.jabfungkode, this.jabfungNama);

//   int pageNumber = 1;
//   void _loadMore() {
//     setState(() {
//       pageNumber++; // increment pageNumber
//       context.read<SdmCubit>().getDosenJabfungPagination(
//           jabfungkode, pageNumber); // fetch the next page of data
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sdmCubits = context.read<SdmCubit>();
//     return Scaffold(
//       appBar:
// AppBar(
//         title: Text(
//           jabfungNama,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: false,
//         titleSpacing: 15.0,
//         backgroundColor: Colors.white,
//       ),
//       body: Container(
//         color: kWhite,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: BlocBuilder<SdmCubit, SdmState>(
//             bloc: sdmCubits..getDosenJabfungPagination(jabfungkode, pageNumber),
//             builder: (context, state) {
//               if (state is DosenJabfungLoaded) {
//                 List<Dosen> dosens = state.datas.data;
//                 return Container(
//                     height: MediaQuery.sizeOf(context).height,
//                     width: MediaQuery.sizeOf(context).width,
//                     color: kWhite,
//                     child: ListView.builder(
//                       itemCount: dosens.length + 1,
//                       itemBuilder: (context, index) {
//                         if (index < dosens.length) {
//                           var dtDosen = dosens[index];
//                           int no = index + 1;
//                           return DosenJabfungItem(
//                             no: no.toString(),
//                             prodi: dtDosen.prodi,
//                             fakultas: dtDosen.fakultas,
//                             dosen: dtDosen.dosen,
//                           );
//                         } else {
//                           return ElevatedButton(
//                             onPressed: _loadMore,
//                             child: Text('Load More'),
//                           );
//                         }
//                       },
//                     ));
//               }
//               return Container(
//                 height: MediaQuery.sizeOf(context).height,
//                 width: MediaQuery.sizeOf(context).width,
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

//eksperimen - it work but need some works - non active temporary
class JabfungDosen extends StatefulWidget {
  final String jabfungkode;
  final String jabfungNama;

  JabfungDosen({Key? key, required this.jabfungkode, required this.jabfungNama})
      : super(key: key);

  @override
  State<JabfungDosen> createState() =>
      _JabfungDosenState(jabfungkode, jabfungNama);
}

class _JabfungDosenState extends State<JabfungDosen> {
  final String jabfungkode;
  final String jabfungNama;

  _JabfungDosenState(this.jabfungkode, this.jabfungNama);

  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    context.read<SdmCubit>().getDosenJabfungPagination(jabfungkode, pageNumber);
  }

  void _loadMore() {
    setState(() {
      pageNumber++; // Increment pageNumber
      context.read<SdmCubit>().getDosenJabfungPagination(
          jabfungkode, pageNumber); // Fetch the next page of data
    });
  }

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
        color: kWhite,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SdmCubit, SdmState>(
            builder: (context, state) {
              print(state);
              if (state is DosenJabfungPaginationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DosenJabfungPaginationLoaded) {
                List<Dosen> dosens = state.datas;
                return ListView.builder(
                  itemCount: dosens.length + 1,
                  itemBuilder: (context, index) {
                    if (index < dosens.length) {
                      var dtDosen = dosens[index];
                      int no = index + 1;
                      return DosenJabfungItem(
                        no: no.toString(),
                        prodi: dtDosen.prodi,
                        fakultas: dtDosen.fakultas,
                        dosen: dtDosen.dosen,
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: _loadMore,
                        child: Text('Load More'),
                      );
                    }
                  },
                );
              } else if (state is DosenJabfungPaginationError) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
