
import 'package:flutter/material.dart';
import 'database/db_helper_mahasiswa.dart';
import 'model/mahasiswa.dart';

/**
 * Nama: Fandy Rizky
 * NIM: 220101020038
 * Kelas: SI701
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  FormMahasiswa({this.mahasiswa});

  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DbHelperMahasiswa db = DbHelperMahasiswa();

  TextEditingController? nama;
  TextEditingController? nip;
  TextEditingController? email;
  TextEditingController? prodi;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.nama);

    nip = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.nip);

    email = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.email);

    prodi = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.prodi);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa Unsia'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nip,
              decoration: InputDecoration(
                  labelText: 'Nip',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: prodi,
              decoration: InputDecoration(
                  labelText: 'Prodi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20
            ),
            child: ElevatedButton(
              child: (widget.mahasiswa == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                upsertMahasiswa();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertMahasiswa() async {
    if (widget.mahasiswa != null) {
      //update
      await db.updateMahasiswa(Mahasiswa.fromMap({
        'id' : widget.mahasiswa!.id,
        'nama' : nama!.text,
        'nip' : nip!.text,
        'email' : email!.text,
        'prodi' : prodi!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveMahasiswa(Mahasiswa(
        nama: nama!.text,
        nip: nip!.text,
        email: email!.text,
        prodi: prodi!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}