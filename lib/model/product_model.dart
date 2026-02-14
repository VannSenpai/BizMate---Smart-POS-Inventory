class ProductModel {
  final String? id;
  final String sku;
  final String nama;
  final int harga;
  final int stok;
  final String deskripsi;
  final String gambar;
  final String? userId;
  final dynamic createdAt;

  ProductModel({
    this.id,
    required this.sku,
    required this.nama,
    required this.harga,
    required this.stok,
    required this.deskripsi,
    required this.gambar,
    this.userId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'nama': nama,
      'harga': harga,
      'stok': stok,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
