///We create the model of our entity with its respective constructors and toJson
class UserModel{
  late String name;
  late String mail;
  late String phone;

  UserModel({required this.name, required  this.mail, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> data){
   return UserModel(
      name: data['name'].toString(),
      phone: data['phone'].toString(),
      mail: data['mail'].toString()
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> userJson ={};

    userJson['name']  = name;
    userJson['mail']  = mail;
    userJson['phone'] = phone;

    return userJson;

  }


}