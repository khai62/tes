// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

class TampilData extends StatefulWidget {
  const TampilData({super.key});

  @override
  State<TampilData> createState() => _TampilDataState();
}

class _TampilDataState extends State<TampilData> with WidgetsBindingObserver {
  DatabaseDB? dbs;

  Future initDatabase() async {
    await dbs!.database(); // Memanggil method database dari databaseInstance.
    setState(() {});
  }

  @override
  void initState() {
    dbs = DatabaseDB();
    initDatabase(); // method intitdatabase di panggil
    super.initState();
  }

  Future delete(int id) async {
    await dbs!.delete(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Tampil'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Icon kembali
            onPressed: () {
              // Aksi ketika tombol kembali ditekan
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Expanded(
              child: dbs != null
                  ? FutureBuilder<List<Category>>(
                      future: dbs!.all(),
                      builder: (context, item) {
                        if (item.hasData) {
                          if (item.data!.length == 0) {
                            return const Center(
                                child: Text('data masih kosong'));
                          }
                          return ListView.builder(
                              itemCount: item.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.data![index].name!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            delete(item.data![index].id!);
                                          },
                                          icon:
                                              const Icon(Icons.delete_forever))
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return Center(child: Text('Error : ${item.error}'));
                        }
                      })
                  : const Center(child: CircularProgressIndicator()),
            )
          ]),
        ),
      ),
    );
  }
}
