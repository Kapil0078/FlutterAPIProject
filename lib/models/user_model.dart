class UserModel {
  final int id;
  final String name;
  final String mobileNumber;
  final String email;
  final String? image;
  final int? age;
  final String? address;

  UserModel({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.email,
    this.image,
    this.age,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        image: json["image"],
        age: json["age"],
        address: json["address"],
      );
}
