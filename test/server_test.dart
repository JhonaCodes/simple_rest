import 'dart:io';

import 'package:simple_rest/simple_rest.dart';
import 'package:test/test.dart';

import '../example/controller/user_controller.dart';

Future<void> main() async{

  final server = SServer.envConfig();
  await server.started([UserController.init]);

  final client = HttpClient();

  test('Test server Port', ()  {
    expect(server.port, equals(8090));
  });

  test("Request verification", () async {
    final request = await client.get('localhost', 8090, '/user/all');
    final response = await request.close();

    expect(response.statusCode, equals(200));
    client.close();
  });


  test("JWT Verificator",(){

    var userJwt = SJwt.generateJWT(
        customSecureKey: SEnviromentData.jwtSecretKey(key: "MY_CUSTOM_NAME"),
        jwtUserInfo:
        {
          "mail": "JHonatan@gmail.com",
        }
    );

    expect(SJwt.verifyUser(token: userJwt)['response'], true);

  });

}
