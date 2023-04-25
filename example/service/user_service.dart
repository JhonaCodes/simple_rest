import '../model/user_model.dart';
import '../repository/user_repository.dart';

/// We make the calls to our databases, we add the data,
/// and we use the repository functions to carry out the previously defined processes
/// and thus see the information we request.
class UserService {

  /// En este punto es donde hacemos los llamados a la infromacion,
  /// procesamos los datos para ser enviados a su respository y se ejecute la accion
  var userRepository = UserRepository();




  Future<List<UserModel>> getAllUsers() async{

    return await userRepository.getAll();
  }

  void saveUser(UserModel userModel)async{

    userRepository.users.add(userModel);

  await userRepository.save(userModel);

  }

  Future<bool> removeUser(String name)async{

    return await userRepository.deleteById(name);
  }


}