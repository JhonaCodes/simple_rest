import '../crud/user_crud.dart';
import '../model/user_model.dart';

/// We create the user model repository for the manipulation and return of requested data.
class UserRepository implements UserCrud{

  List<UserModel> users = [];

  @override
  Future<List<UserModel>> getAllUser() async{
    return users;
  }

}