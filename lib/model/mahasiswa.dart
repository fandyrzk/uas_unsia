/**
 * Nama: Fandy Rizky
 * NIM: 220101020038
 * Kelas: SI701
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class Mahasiswa{
  int? id;
  String? nama;
  String? nip;
  String? email;
  String? prodi;

  Mahasiswa({this.id, this.nama, this.nip, this.email, this.prodi});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['nip'] = nip;
    map['email'] = email;
    map['prodi'] = prodi;

    return map;
  }

  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.nip = map['nip'];
    this.email = map['email'];
    this.prodi = map['prodi'];
  }
}