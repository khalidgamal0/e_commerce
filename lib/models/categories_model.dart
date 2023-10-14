class CategoriesModel {
  final bool status;
  final CategoriesDataModel data;

  CategoriesModel({required this.status, required this.data});
  factory CategoriesModel.fromJson(Map<String, dynamic> jsonData) {
    return CategoriesModel(
      status: jsonData['status'],
      data: CategoriesDataModel.fromJson(jsonData['data']),
    );
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel> data = [];

  CategoriesDataModel({required this.currentPage, required this.data});

  CategoriesDataModel.fromJson(Map<String, dynamic> jsonData) {
    currentPage = jsonData['current_page'];
    jsonData['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  final int id;
  final String name;
  final String image;

  DataModel({required this.id, required this.name, required this.image});

  factory DataModel.fromJson(Map<String, dynamic> jsonData) {
    return DataModel(
      id: jsonData['id'],
      name: jsonData['name'],
      image: jsonData['image'],
    );
  }
}
