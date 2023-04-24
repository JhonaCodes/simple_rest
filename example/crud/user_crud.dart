import '../model/user_model.dart';

///The methods that will be used in the logic of our api are established.
mixin UserCrud{
  Future<List<UserModel>> getAllUser();
  void saveUser(UserModel userModel);

}