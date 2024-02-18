import 'package:flutter/material.dart';
import 'form_mahasiswa.dart';

import 'database/db_helper_mahasiswa.dart';
import 'model/mahasiswa.dart';

/**
 * Nama: Fandy Rizky
 * NIM: 220101020038
 * Kelas: SI701
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class ListMahasiswaPage extends StatefulWidget {
  const ListMahasiswaPage({ Key? key }) : super(key: key);

  @override
  _ListMahasiswaPageState createState() => _ListMahasiswaPageState();
}

class _ListMahasiswaPageState extends State<ListMahasiswaPage> {
  List<Mahasiswa> listMahasiswa = [];
  DbHelperMahasiswa db = DbHelperMahasiswa();

  @override
  void initState() {
    _getAllMahasiswa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(
          child: Text("List Mahasiswa Unsia"),
        ),
      ),
      body: ListView.builder(
          itemCount: listMahasiswa.length,
          itemBuilder: (context, index) {
            Mahasiswa mahasiswa = listMahasiswa[index];
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10
              ),
              child: ListTile(
                title: Text(
                    '${mahasiswa.nama}'
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${mahasiswa.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Phone: ${mahasiswa.nip}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Prodi: ${mahasiswa.prodi}"),
                    )
                  ],
                ),
                trailing:
                FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(mahasiswa);
                          },
                          icon: Icon(Icons.edit)
                      ),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${mahasiswa.nama}"
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteMahasiswa(mahasiswa, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")
                              ),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _openFormCreate();
        },
      ),

    );
  }

  //mengambil semua data
  Future<void> _getAllMahasiswa() async {
    var list = await db.getAllMahasiswa();
    setState(() {
      listMahasiswa.clear();
      list!.forEach((mahasiswa) {
        listMahasiswa.add(Mahasiswa.fromMap(mahasiswa));
      });
    });
  }

  //hapus data
  Future<void> _deleteMahasiswa(Mahasiswa mahasiswa, int position) async {
    await db.deleteMahasiswa(mahasiswa.id!);
    setState(() {
      listMahasiswa.removeAt(position);
    });
  }

  // halaman tambah
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMahasiswa()));
    if (result == 'save') {
      await _getAllMahasiswa();
    }
  }

  //halaman edit
  Future<void> _openFormEdit(Mahasiswa mahasiswa) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormMahasiswa(mahasiswa: mahasiswa)));
    if (result == 'update') {
      await _getAllMahasiswa();
    }
  }
}