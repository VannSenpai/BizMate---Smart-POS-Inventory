class InventoryModel {
  String? id;
  String gambar;
  String nama;
  String sku;
  int harga;
  int stok;

  InventoryModel({
    this.id,
    required this.gambar,
    required this.nama,
    required this.sku,
    required this.harga,
    required this.stok,
  });
}
