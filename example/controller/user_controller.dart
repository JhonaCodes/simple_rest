import 'package:simple_rest/simple_rest.dart';

import '../model/user_model.dart';

import '../service/user_service.dart';


///We use our [UserController] to call the data from our service,
///then transform it into a json using our [userModel] function [toJson]
///and transform it into a [List] to return a [Map] listing.
class UserController  {

  static var userService = UserService();

  static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();

    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();


    /// We can call the data that the user sends by reference.
    /// We just need to use the [SController] class and call the [request.uri.queryParameters] tribute
    /// We call the key with which the sent value is supposed to be identified and that's it
    SController.request.uri.queryParameters['id'];

    ///After processing our information, we subscribe our data
    ///to the response string to be displayed -
    ///under the query made by our client, which is -
    ///managed by our [simple_rest] library
    SController.subscribeData(
      jsonDataList: usersJson
    );



  }


  /// We create our init function inside the [UserController] class
  /// this should contain our function [registerEndpoints]
  /// fetched from [SController]
  /// inside this we register our [endPoints],
  /// using the [SRouterController] case as a model and for Http requests,
  /// we use the [SHttpMethod] class which in this case is a [GET] type
  /// We create our path which can be literal or list of text.
  /// We add the function in this case [getAllUser] and that's it.
  static void init() {

    SController.registerEndpoints(endPoints: [
      SRouterController(
        http: SHttpMethod.GET,
        literalPath: 'user/all',
        function: getAllUser,
      ),
    ]);
  }

}