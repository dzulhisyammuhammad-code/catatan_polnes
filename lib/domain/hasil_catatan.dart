import 'catatan.dart';

sealed class HasilCatatan {}

class HasilMemuat extends HasilCatatan {}

class HasilKosong extends HasilCatatan {}

class HasilGalat extends HasilCatatan {
  final String pesan;
  HasilGalat(this.pesan);
}

class HasilSebagian extends HasilCatatan {
  final List<Catatan> data;
  final String peringatan;
  HasilSebagian(this.data, this.peringatan);
}

class HasilBerhasil extends HasilCatatan {
  final List<Catatan> data;
  HasilBerhasil(this.data);
}
