import 'package:simple_rest/simple_rest.dart';
import 'package:simple_rest/src/helpers/s_serializator.dart';

import '../model/user_model.dart';

import '../service/user_service.dart';


///We use our [UserController] to call the data from our service,
///then transform it into a json using our [userModel] function [toJson]
///and transform it into a [List] to return a [Map] listing.
class UserController  {

  static var userService = UserService();

  /// Example GET
  static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();

    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();

    Logs.response(title: "GET VALUE CLIENT", msm:  await SSerializer.build( SController.request ));

    /// We can call the data that the user sends by reference.
    /// We just need to use the [SController] class and call the [request.uri.queryParameters] tribute
    /// We call the key with which the sent value is supposed to be identified and that's it
    //SController.request.uri.pathSegments;

    ///After processing our information, we subscribe our data
    ///to the response string to be displayed -
    ///under the query made by our client, which is -
    ///managed by our [simple_rest] library
    SController.subscribeData(
      jsonDataList: usersJson
    );

  }


  /// Example POST
  static Future<void> saveUser() async{

    /// Coming data form json format
    /// use [SSerializer.build(SController.request)]
    /// Read Data with SController.request
    /// Serialize data with [SSerializer.build]
    UserModel userModel = UserModel.fromJson(
        await SSerializer.build( SController.request )
    );

    userService.saveUser(userModel);

    SController.subscribeData(
        jsonDataList: [userModel.toJson()]
    );

  }

  /// Example DELETE
  static Future<bool> deleteUser()async{





    var nameOrId = await SSerializer.build( SController.request );

    Logs.response(title: "DELETE VALUE CLIENT", msm:  nameOrId['name'].toString());

    bool statusDeleteUser = userService.removeUser(nameOrId['name'].toString());

    SController.subscribeData(
        jsonData: {
          "response": statusDeleteUser
        }
    );

    return true;

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

      SRouterController(
        http: SHttpMethod.POST,
        literalPath: 'user',
        function: saveUser,
      ),

      SRouterController(
        http: SHttpMethod.DELETE,
        literalPath: 'user/',
        function: deleteUser,
      ),

    ]);
  }

}