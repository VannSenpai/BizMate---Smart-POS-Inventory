class InventoryModel {
  String? id;
  String gambar;
  String nama;
  String? deskripsi;
  String sku;
  int harga;
  int stok;
  String? userId;
  dynamic createdAt;

  InventoryModel({
    this.id,
    required this.gambar,
    required this.nama,
    this.deskripsi,
    required this.sku,
    required this.harga,
    required this.stok,
    this.userId,
    this.createdAt,
  });
}
