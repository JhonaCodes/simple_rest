import 'package:simple_rest/simple_rest.dart';

import '../crud/user_crud.dart';
import '../model/user_model.dart';

/// We create the user model repository for the manipulation and return of requested data.
class UserRepository implements UserCrud{

  /// En este se pone como procesamos la informacion recibida, crear, eliminar, etc etc, la logica en general

  List<UserModel> users = [
  UserModel(name: "name1", mail: "mail 1", phone: "phone 1"),
  UserModel(name: "name2", mail: "mail 2", phone: "phone 2"),
  UserModel(name: "name3", mail: "mail 3", phone: "phone 3"),
  UserModel(name: "name4", mail: "mail 4", phone: "phone 4"),
  UserModel(name: "name5", mail: "mail 5", phone: "phone 5"),
  ];


  @override
  Future<bool> deleteById(Object id) async{
    bool validation = false;

    users.removeWhere((element) =>  (element.name == id.toString()) ? validation = true : validation = false );
    Logs.info(title: "ESTADO ELIMINACION", msm: users);

    return validation;
  }

  @override
  Future<List<UserModel>> getAll() async{
    // TODO: implement getAll
    return users;
  }

  @override
  Future<UserModel> getById(Object id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<UserModel> save(UserModel entity) async{
    users.add(entity);

    return entity;
  }

  @override
  Future<UserModel> update(UserModel entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

}