class UserModel {
  String uID;
  String name;
  String email;
  String image;

  UserModel({
    this.uID,
    this.email,
    this.name,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uID = json['uID'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> ToMap() {
    return {
      'name': name,
      'uID': uID,
      'email': email,
      'image': image,
    };
  }
}
