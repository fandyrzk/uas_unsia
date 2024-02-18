
import 'package:flutter/material.dart';
import 'database/db_helper_dosen.dart';
import 'model/dosen.dart';

/**
 * Nama: Fandy Rizky
 * NIM: 220101020038
 * Kelas: SI701
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class FormDosen extends StatefulWidget {
  final Dosen? dosen;

  FormDosen({this.dosen});

  @override
  _FormDosenState createState() => _FormDosenState();
}

class _FormDosenState extends State<FormDosen> {
  DbHelperDosen db = DbHelperDosen();

  TextEditingController? nama;
  TextEditingController? email;

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.dosen == null ? '' : widget.dosen!.nama);

    email = TextEditingController(
        text: widget.dosen == null ? '' : widget.dosen!.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Dosen Unsia'),
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
                top: 20
            ),
            child: ElevatedButton(
              child: (widget.dosen == null)
                  ? Text(
                'Add',
                style: TextStyle(color: Colors.white),
              )
                  : Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                upsertDosen();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertDosen() async {
    if (widget.dosen != null) {
      //update
      await db.updateDosen(Dosen.fromMap({
        'id' : widget.dosen!.id,
        'nama' : nama!.text,
        'email' : email!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveDosen(Dosen(
        nama: nama!.text,
        email: email!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}