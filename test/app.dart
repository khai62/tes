import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Definisikan kelas Category
class Category {
  final int id;
  final String name;
  final String text;
  final dynamic image;
  final double height;

  // Buat constructor untuk Category
  Category({
    required this.id,
    required this.name,
    required this.text,
    required this.height,
    required this.image,
  });

  // Factory method untuk membuat objek Category dari map JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      text: json['text'],
      height: json['height'],
      image: json['image'],
    );
  }

  // Method untuk mengonversi objek Category menjadi map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'text': text,
      'image': image,
      'height': height,
    };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Buka atau buat database SQLite saat aplikasi pertama kali dijalankan
  final database = openDatabase(
    join(await getDatabasesPath(), 'category_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, text TEXT, image TEXT, height REAL)',
      );
    },
    version: 1,
  );

  // Jalankan aplikasi dengan database yang telah dibuat
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Future<Database> database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(database: database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Future<Database> database;

  const MyHomePage({super.key, required this.database});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // Method untuk menyimpan data dari dataList ke dalam database
  late Future<List<Category>> categories;
  @override
  void initState() {
    super.initState();
    categories = getCategories(); // Panggil getCategories() di initState
  }

  Future<void> insertCategories(Database database) async {
    for (var category in dataList) {
      await database.insert(
        'categories',
        category.toMap(), // Konversi objek Category menjadi map
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Ganti data jika sudah ada konflik
      );
    }
  }

  Future<List<Category>> getCategories() async {
    final Database db = await widget.database; // Ambil database dari Future
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
        text: maps[i]['text'],
        height: maps[i]['height'],
        image: maps[i]['image'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: FutureBuilder<List<Category>>(
        // Ambil data kategori dari database
        future: categories,
        builder:
            (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            // Jika data tersedia, tampilkan ListView
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Category category = snapshot.data![index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.text),
                  leading: Image.asset(
                    category
                        .image, // Tampilkan gambar sesuai path yang disimpan di database
                    height: 50,
                    width: 50,
                  ),
                  onTap: () {
                    // Tambahkan aksi yang diinginkan saat item diklik di sini
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            // Jika terjadi kesalahan, tampilkan pesan kesalahan
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          // Tampilkan indikator loading jika data sedang dimuat
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// Data kategori yang akan dimasukkan ke dalam database
List<Category> dataList = [
  Category(
    id: 1,
    name: 'Alberd Einstein',
    text: 'Teori relativitas',
    height: 220.0,
    image: 'assets/images/einsten1.png',
  ),
  Category(
    id: 2,
    name: 'Al Khawarizmi',
    text: 'Teori aljabar (penulis Aritmetika)',
    height: 260.0,
    image: 'assets/images/Al_Khawarizmi2.png',
  ),
  Category(
    id: 3,
    name: 'Alessandro Volta',
    text: 'Baterai',
    height: 220.0,
    image: 'assets/images/Alessandro_Volta1.png',
  ),
  Category(
    id: 4,
    name: 'Alfred Nobel',
    text: 'Bom dinamit',
    height: 220.0,
    image: 'assets/images/Alfred_Nobel1.png',
  ),
  Category(
    id: 5,
    name: 'Alexander Graham Bell',
    text: 'Telepon Kabel (Versi Lama), Piringan hitam',
    height: 220.0,
    image: 'assets/images/Alexander_Graham1.png',
  ),
  Category(
    id: 6,
    name: 'Antonie van Leeuwenhook',
    text: 'Lensa',
    height: 220.0,
    image: 'assets/images/AntonievanLeeuwenhook1.png',
  ),
  Category(
    id: 8,
    name: 'Antonio Meucci',
    text: 'Telepon (Versi Baru 2002)',
    height: 220.0,
    image: 'assets/images/Antonio_Meucci1.png',
  ),
  Category(
    id: 9,
    name: 'Artur Fischer',
    text: 'Dowel Fischer',
    height: 220.0,
    image: 'assets/images/ArturFischer2.png',
  ),
  Category(
    id: 10,
    name: 'Benjamin Holt',
    text: 'Traktor',
    height: 220.0,
    image: 'assets/images/Benjamin_Holt2.png',
  ),
];
