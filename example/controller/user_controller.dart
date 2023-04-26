import 'package:simple_rest/simple_rest.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';

///We use our [UserController] to call the data from our service,
///then transform it into a json using our [userModel] function [toJson]
///and transform it into a [List] to return a [Map] listing.
class UserController {

  /// This class interacts with the service and processes the received information by sending it to the SubscribeData method.
  static var userService = UserService();

  /// Example GET
  static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();
    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();

    ///After processing our information, we subscribe our data
    ///to the response string to be displayed -
    ///under the query made by our client, which is -
    ///managed by our [simple_rest] library
    SController.subscribeData(
      jsonDataList: usersJson
    );

  }

  /// The get parameters on link
  static Future<void> getUserByName()async{

    var uri = Uri.parse(SController.request.uri.toString());

    var idOrName = uri.queryParameters['Id'];
    Logs.info(title: "QUERRY PARAMETERS", msm: idOrName);

    SController.subscribeData(
        jsonData: uri.queryParameters
    );

  }

  /// Example POST
  static Future<void> saveUser() async{

    /// Coming data form json format
    /// use [SSerializer.build(SController.request)]
    /// Read Data with SController.request
    /// Serialize data with [SSerializer.build]
    UserModel userModel = UserModel.fromJson(
        await SSerializer.buildModel( SController.request )
    );

    userService.saveUser(userModel);

    SController.subscribeData(
        jsonDataList: [userModel.toJson()]
    );

  }

  /// Example Upload File
  static Future<void> saveFile() async{

    Map status = {};

    /// This way we save all types of files.
    /// You define at this point what type of files and size you allow.
    /// the response is added to your variable in this case [status].
    /// you name it whatever you want.
    /// don't end your path with [/].
    await SSerializer.buildFile(
        SController.request,
        pathToSaveFile: '/Volumes/Data/DartLang/files_simple_rest',
    ).then((value) => status = value);


    SController.subscribeData(
        jsonDataList: [status]
    );


  }

  /// Example DELETE
  static Future<bool> deleteUser()async{

    /// In this way you use the data that you add to the url of your request
    var uri = Uri.parse(SController.request.uri.toString());
    var idOrName = uri.queryParameters['id'];
    /// At this point you get the id of your user in the variable[idOrName]

    bool statusDeleteUser = await userService.removeUser(idOrName.toString());

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
        http: SHttpMethod.GET,
        literalPath: 'user/',
        function: getUserByName,
      ),

      SRouterController(
        http: SHttpMethod.POST,
        literalPath: 'user',
        function: saveUser,
      ),

      /// To send values or parameters in the link.
      /// You must end the path with [/]
      /// on the client should have something like [http://myapihost:123/user/?id=12e23ed23e]
      SRouterController(
        http: SHttpMethod.DELETE,
        literalPath: 'user/',
        function: deleteUser,
      ),

      /// In this way, the path and the function that is responsible for adding files are added.
      /// In this case the idea was to add photos, you can put the path that you like best.
      SRouterController(
        http: SHttpMethod.POST,
        literalPath: 'user/photo',
        function: saveFile,
      ),
    ]);
  }

}