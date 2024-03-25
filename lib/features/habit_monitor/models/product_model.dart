class ProductModel {
  final String imgUrl;
  final String productName;
  final String qnt;
  final bool isFav;
  final String category;
  final int cartQnt;

  ProductModel({
    required this.imgUrl,
    required this.category,
    required this.productName,
    required this.qnt,
    this.isFav = false,
    this.cartQnt = 1,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      imgUrl: data["imgUrl"],
      productName: data['productName'],
      qnt: data['qnt'],
      category: data['category'],
    );
  }
}
