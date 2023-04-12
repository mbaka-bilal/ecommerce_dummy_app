class ProductModel {
  ProductModel({required this.title,required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  String toString() {
    return "ProductModel{$title,$imageUrl}";
  }
}