
import 'package:flutter/material.dart';
import 'package:tugas_crud_unsia/list_mahasiswa.dart';
import 'package:tugas_crud_unsia/list_dosen.dart';

/**
 * Nama: Fandy Rizky
 * NIM: 220101020038
 * Kelas: SI701
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Halaman Utama"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(25),
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListMahasiswaPage()));
              },
              splashColor: Colors.blue,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.face, size: 70, color: Colors.blue,),
                    Text("Mahasiswa", style: TextStyle(fontSize: 17.0),)
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListDosenPage()));
              },
              splashColor: Colors.blue,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.person, size: 70, color: Colors.blue,),
                    Text("Dosen", style: TextStyle(fontSize: 17.0),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
