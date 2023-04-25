///We create the model of our entity with its respective constructors and toJson
class UserModel{
  late String name;
  late String mail;
  late String phone;

  UserModel({required this.name, required  this.mail, required this.phone});

  factory UserModel.fromJson(Map<dynamic, dynamic> data){
   return UserModel(
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      mail: data['mail'] ?? ''
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> userJson ={};

    userJson['name'] = name;
    userJson['mail'] = mail;
    userJson['phone'] = phone;

    return userJson;

  }


}