import 'package:simple_rest/simple_rest.dart';

import '../crud/user_crud.dart';
import '../model/user_model.dart';

/// We create the user model repository for the manipulation and return of requested data.
class UserRepository implements UserCrud{

  List<UserModel> users = [
  UserModel(name: "name1", mail: "mail 1", phone: "phone 1"),
  UserModel(name: "name2", mail: "mail 2", phone: "phone 2"),
  UserModel(name: "name3", mail: "mail 3", phone: "phone 3"),
  UserModel(name: "name4", mail: "mail 4", phone: "phone 4"),
  UserModel(name: "name5", mail: "mail 5", phone: "phone 5"),
  ];

  @override
  Future<List<UserModel>> getAllUser() async{
    return users;
  }

  @override
  void saveUser(UserModel userModel) {

    users.add(userModel);

  }

  @override
  bool deleteUser(String name) {

    bool? validation;

    users.removeWhere((element) => element.name == name);
    Logs.info(title: "ESTADO ELIMINACION", msm: users);

    users.map((e) {
      Logs.info(title: "ESTADO ELIMINACION NAME", msm: e.name);
      e.name == name ? validation = false : validation = true;
    });

    return true;

  }

}