class ProdukModel {
  int? id; // Variabel untuk menyimpan ID produk.
  String? name,
      category,
      createAt,
      updateAt; // Variabel untuk menyimpan nama, kategori, tanggal pembuatan, dan tanggal pembaruan produk.

  ProdukModel(
      {this.id,
      this.name,
      this.category,
      this.createAt,
      this.updateAt}); // Konstruktor untuk kelas ProdukModel.

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    // Fungsi factory untuk membuat objek ProdukModel dari data JSON.
    return ProdukModel(
      id: json['id'], // Mengambil nilai ID dari JSON.
      name: json['name'],
      category: json['category'],
      createAt: json['create_at'],
      updateAt: json['update_at'],  
    );
  }
}
