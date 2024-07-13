class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class AkreditasiInternasional {
  final String prodi;
  final int percent;
  final String value;

  AkreditasiInternasional(this.prodi, this.percent, this.value);
}

class Ranking {
  final String year;
  final double percent;

  Ranking(this.year, this.percent);
}

class DetailRanking {
  final String scope;
  final int rank;

  DetailRanking(this.scope, this.rank);
}

class PendidikanDosen {
  final String pendidikanDosen;
  final String persentase;
  final String total;

  PendidikanDosen(this.pendidikanDosen, this.persentase, this.total);
}

class JabatanFungsionalDosen {
  final String jabfungDosen;
  final String persentase;
  final String total;

  JabatanFungsionalDosen(this.jabfungDosen, this.persentase, this.total);
}

class PersebaranProdiDosen {
  final String prodi;
  final String persentase;
  final String total;

  PersebaranProdiDosen(this.prodi, this.persentase, this.total);
}