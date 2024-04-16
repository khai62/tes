// import 'package:tes/pustaka.dart';

// class dan constructor list
class Category {
  final int? id;
  final String? name;
  final String? text;
  final dynamic image;
  final dynamic height;

  Category({
    this.id,
    this.name,
    this.text,
    this.height,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      text: json['text'],
      height: json['height'],
      image: json['image'],
    );
  }
}

// data list
List<Category> dataList = [
  Category(
    name: 'Alberd Einstein',
    text: 'Teori relativitas',
    height: 220.0,
    image: 'assets/images/einsten1.png',
  ),
  Category(
    // id: 2,
    name: 'Al Khawarizmi',
    text: 'Teori aljabar (penulis Aritmetika)',
    height: 260.0,
    image: 'assets/images/Al_Khawarizmi2.png',
  ),
  Category(
    // id: 3,
    name: 'Alessandro Volta',
    text: 'Baterai',
    height: 220.0,
    image: 'assets/images/Alessandro_Volta1.png',
  ),
  Category(
    // id: 4,
    name: 'Alfred Nobel',
    text: 'Bom dinamit',
    height: 220.0,
    image: 'assets/images/Alfred_Nobel1.png',
  ),
  Category(
    // id: 5,
    name: 'Alexander Graham Bell',
    text: 'Telepon Kabel (Versi Lama), Piringan hitam',
    height: 220.0,
    image: 'assets/images/Alexander_Graham1.png',
  ),
  Category(
    // id: 6,
    name: 'Antonie van Leeuwenhook',
    text: 'Lensa',
    height: 220.0,
    image: 'assets/images/AntonievanLeeuwenhook1.png',
  ),
  Category(
    // id: 8,
    name: 'Antonio Meucci',
    text: 'Telepon (Versi Baru 2002)',
    height: 220.0,
    image: 'assets/images/Antonio_Meucci1.png',
  ),
  Category(
    // id: 9,
    name: 'Artur Fischer',
    text: 'Dowel Fischer',
    height: 220.0,
    image: 'assets/images/ArturFischer2.png',
  ),
  Category(
    // id: 10,
    name: 'Benjamin Holt',
    text: 'Traktor',
    height: 220.0,
    image: 'assets/images/Benjamin_Holt2.png',
  ),
];
