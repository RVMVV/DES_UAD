import 'package:flutter/material.dart';

class DosenJabfungItem extends StatefulWidget {
  DosenJabfungItem(
      {super.key,
      required this.no,
      required this.prodi,
      required this.fakultas,
      required this.dosen});

  String no;
  String prodi;
  String fakultas;
  String dosen;

  @override
  State<DosenJabfungItem> createState() => _DosenJabfungItemState();
}

class _DosenJabfungItemState extends State<DosenJabfungItem> {
  bool isShow = false;
  Color? warnaMasa = Colors.red[250];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.no + '. ' + widget.dosen,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: isShow
                    ? Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 30.0,
                      )
                    : Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                        size: 30.0,
                      ),
              )
            ],
          ),
        ),
        Visibility(
          visible: isShow,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                Container(
                  width: 350.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Fakultas',
                        ),
                        Text(
                          widget.fakultas,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  width: 350.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Program Studi',
                        ),
                        Text(
                          widget.prodi,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
