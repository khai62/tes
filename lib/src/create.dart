import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance =
      DatabaseInstance(); // Instance dari DatabaseInstance.
  TextEditingController namedController =
      TextEditingController(); // Controller untuk input nama produk
  TextEditingController categoryControler =
      TextEditingController(); // Controller untuk input kategori produk.

  @override
  void initState() {
    databaseInstance
        .database(); // Memanggil method database dari databaseInstance.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tambah data'),
        backgroundColor: Colors.blue[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('nama Produk'),
            TextField(
              controller:
                  namedController, // Menghubungkan controller input dengan TextField.
            ),
            const Text('kategory'),
            TextField(
              controller:
                  categoryControler, // Menghubungkan controller input dengan TextField.
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  // Ketika tombol disimpan ditekan:
                  await databaseInstance.insert({
                    'name ': namedController
                        .text, // Memasukkan nilai nama produk ke dalam database.
                    'category ': categoryControler
                        .text, // Memasukkan nilai kategori produk ke dalam database.
                    'create_at ': DateTime.now()
                        .toString(), // Menambahkan waktu pembuatan
                    'update_at': DateTime.now()
                        .toString(), // Menambahkan waktu pembaruan.
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(
                      context); // Kembali ke layar sebelumnya setelah menyimpan data.
                },
                child: const Text('simpan')) // Tombol untuk menyimpan data.
          ],
        ),
      ),
    );
  }
}
