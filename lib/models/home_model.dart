class HomeModel {
  final bool status;
  final HomeDataModel data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson(Map<String, dynamic> jsonData) {
    return HomeModel(
      status: jsonData['status'],
      data: HomeDataModel.fromJson(jsonData['data']),
    );
  }
}

class HomeDataModel {
  final List<BannersModel> banners = [];
  final List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> jsonData) {
    jsonData['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    jsonData['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  final int id;
  final String image;

  BannersModel({required this.id, required this.image});

  factory BannersModel.fromJson(Map<String, dynamic> jsonData) {
    return BannersModel(
      id: jsonData['id'],
      image: jsonData['image'],
    );
  }
}

class ProductsModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final bool inFavorites;
  final bool inCart;

  ProductsModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductsModel(
      id: jsonData['id'],
      price: jsonData['price'],
      oldPrice: jsonData['old_price'],
      discount: jsonData['discount'],
      image: jsonData['image'],
      name: jsonData['name'],
      inFavorites: jsonData['in_favorites'],
      inCart: jsonData['in_cart'],
    );
  }
}
