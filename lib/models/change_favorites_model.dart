class ChangeFavoritesModel {
  final bool status;
  final String message;

  ChangeFavoritesModel({required this.status, required this.message});

  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> jsonData) {
    return ChangeFavoritesModel(
        status: jsonData['status'], message: jsonData['message']);
  }
}
