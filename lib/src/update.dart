import 'package:flutter/material.dart';
import 'package:tes/pustaka.dart';

class UpgradeScreen extends StatefulWidget {
  final ProdukModel? produkModel;
  const UpgradeScreen({Key? key, this.produkModel}) : super(key: key);

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
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
    namedController.text = widget.produkModel!.name ?? '';
    categoryControler.text = widget.produkModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit'),
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
                  await databaseInstance.update(widget.produkModel!.id!, {
                    'name ': namedController
                        .text, // mengupdate nilai nama produk ke dalam database.
                    'category ': categoryControler
                        .text, // update nilai kategori produk ke dalam database.

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
