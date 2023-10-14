class LoginModel {
  final bool status;
  final String? message;
  final DataModel? data;
  LoginModel({required this.data, required this.status, required this.message});

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      data: jsonData['data'] != null
          ? DataModel.fromJson(jsonData['data'])
          : null,
      status: jsonData['status'],
      message: jsonData['message'],
    );
  }
}

class DataModel {
  final int id;
  final String  name;
  final String  email;
  final String  phone;
  final String image;
  final int ? points;
  final int ? credit;
  final String token;

  DataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory DataModel.fromJson(Map<String, dynamic> jsonData) {
    return DataModel(
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      image: jsonData['image'],
      points: jsonData['points'],
      credit: jsonData['credit'],
      token: jsonData['token'],
    );
  }
}
