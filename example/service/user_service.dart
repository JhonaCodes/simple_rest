import '../model/user_model.dart';
import '../repository/user_repository.dart';

/// We make the calls to our databases, we add the data,
/// and we use the repository functions to carry out the previously defined processes
/// and thus see the information we request.
class UserService {

  var userRepository = UserRepository();

  Future<List<UserModel>> getAllUsers() async{

    userRepository.users.clear();

    userRepository.users.addAll([
      UserModel(name: "name 1", mail: "mail 1", phone: "phone 1"),
      UserModel(name: "name 2", mail: "mail 2", phone: "phone 2"),
      UserModel(name: "name 3", mail: "mail 3", phone: "phone 3"),
      UserModel(name: "name 4", mail: "mail 4", phone: "phone 4"),
      UserModel(name: "name 5", mail: "mail 5", phone: "phone 5"),
    ]
    );

    return await userRepository.getAllUser();
  }

  void saveUser(UserModel userModel)async{

    userRepository.users.add(userModel);
    userRepository.saveUser(userModel);

  }



}