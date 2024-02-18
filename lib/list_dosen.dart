import 'package:flutter/material.dart';
import 'form_dosen.dart';
import 'database/db_helper_dosen.dart';
import 'model/dosen.dart';

/**
 * Nama: Devi Ardiana
 * NIM: 220101020015
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class ListDosenPage extends StatefulWidget {
  const ListDosenPage({ Key? key }) : super(key: key);

  @override
  _ListDosenPageState createState() => _ListDosenPageState();
}

class _ListDosenPageState extends State<ListDosenPage> {
  List<Dosen> listDosen = [];
  DbHelperDosen db = DbHelperDosen();

  @override
  void initState() {
    _getAllDosen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(
          child: Text("List Dosen Unsia"),
        ),
      ),
      body: ListView.builder(
          itemCount: listDosen.length,
          itemBuilder: (context, index) {
            Dosen dosen = listDosen[index];
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10
              ),
              child: ListTile(
                title: Text(
                    '${dosen.nama}'
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${dosen.email}"),
                    ),
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
                            _openFormEdit(dosen);
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
                                      "Yakin ingin Menghapus Data ${dosen.nama}"
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    _deleteDosen(dosen, index);
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
  Future<void> _getAllDosen() async {
    var list = await db.getAllDosen();
    setState(() {
      listDosen.clear();
      list!.forEach((dosen) {
        listDosen.add(Dosen.fromMap(dosen));
      });
    });
  }

  //hapus data
  Future<void> _deleteDosen(Dosen dosen, int position) async {
    await db.deleteDosen(dosen.id!);
    setState(() {
      listDosen.removeAt(position);
    });
  }

  // halaman tambah
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormDosen()));
    if (result == 'save') {
      await _getAllDosen();
    }
  }

  //halaman edit
  Future<void> _openFormEdit(Dosen dosen) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormDosen(dosen: dosen)));
    if (result == 'update') {
      await _getAllDosen();
    }
  }
}