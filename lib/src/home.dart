// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  DatabaseInstance? databaseIntance; //objek database instance

  Future _refresh() async {
    setState(() {}); // Mengatur ulang state untuk merefresh
  }

  Future initDatabase() async {
    await databaseIntance!
        .database(); // Memanggil method database dari databaseInstance.
    setState(() {});
  }

  // method hapus
  Future delete(int id) async {
    await databaseIntance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    databaseIntance = DatabaseInstance();
    initDatabase(); // method intitdatabase di panggil
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const MyAppbar(),
        body: RefreshIndicator(
          onRefresh: _refresh, //memanggil fungsi refresh
          child: databaseIntance != null
              ? FutureBuilder<List<ProdukModel>>(
                  future: databaseIntance!
                      .all(), // Mengambil data dari databaseInstance.
                  builder: (context, snepshot) {
                    if (snepshot.hasData) {
                      //logika jika data sudah ada
                      if (snepshot.data!.length == 0) {
                        // logika jika data kosong
                        return const Center(child: Text('data masih kosong'));
                      }
                      return ListView.builder(
                          itemCount:
                              snepshot.data!.length, //jumlah item datalist view
                          itemBuilder: (context, index) {
                            return ListTile(
                              // untuk menampilkan data nama dari database
                              title: Text(snepshot.data![index].name ?? ''),
                              // untuk menampilkan data kategory dari database
                              leading: IconButton(
                                onPressed: () =>
                                    delete(snepshot.data![index].id!),
                                icon: const Icon(Icons.delete),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpgradeScreen(
                                                produkModel:
                                                    snepshot.data![index],
                                              ))).then((value) {
                                    setState(() {});
                                  });
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              subtitle:
                                  Text(snepshot.data![index].category ?? ''),
                            );
                          });
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        //jika data belum ada
                        color: Colors.blue[200],
                      ));
                    }
                  })
              : Center(
                  child: CircularProgressIndicator(
                  //jika data belum ada
                  color: Colors.blue[200],
                )),
        ),
      ),
    );
  }
}
