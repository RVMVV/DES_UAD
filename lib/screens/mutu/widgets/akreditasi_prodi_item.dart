import 'package:flutter/material.dart';

class AkreditasiProdiItem extends StatefulWidget {
  AkreditasiProdiItem(
      {super.key,
      required this.no,
      required this.prodi,
      required this.fakultas,
      required this.lembaga,
      required this.masaBerlaku,
      required this.warna});

  String no;
  String prodi;
  String fakultas;
  String lembaga;
  String masaBerlaku;
  String warna;

  @override
  State<AkreditasiProdiItem> createState() => _AkreditasiProdiItemState();
}

class _AkreditasiProdiItemState extends State<AkreditasiProdiItem> {
  bool isShow = false;
  Color? warnaMasa = Colors.grey[250];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    widget.no + '. ' + widget.prodi,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  (widget.warna != '')
                      ? Container(
                          height: 8.0,
                          width: 8.0,
                          color: (widget.warna == 'warning')
                              ? Colors.orange
                              : Colors.red,
                        )
                      : Text(''),
                ],
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
                    color: warnaMasa,
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
                SizedBox(height: 5),
                if (widget.lembaga != '')
                  Container(
                    width: 350.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: warnaMasa,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lembaga Akreditasi',
                          ),
                          Text(
                            widget.lembaga,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (widget.lembaga != '') SizedBox(height: 5),
                Container(
                  width: 350.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: (widget.warna == 'danger')
                        ? Colors.red
                        : (widget.warna == 'warning')
                            ? Colors.orange
                            : warnaMasa,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Masa Berlaku',
                            style: TextStyle(
                                color: (widget.warna == 'danger')
                                    ? Colors.white
                                    : Colors.black)),
                        Text(
                          widget.masaBerlaku,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (widget.warna == 'danger')
                                  ? Colors.white
                                  : Colors.black),
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
