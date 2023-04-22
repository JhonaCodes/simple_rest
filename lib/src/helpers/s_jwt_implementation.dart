import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../utils/s_enviroment_data.dart';
import '../utils/s_logs.dart';

/// Clase para manejo de JWT, generar y  verificar
/// generar [generateJWT] y verificar [verifyUser]
/// Se peude agregar datos personalizados o dejar por defecto.
/// Los valores opcionales si usted configuro el archivo [.ev],
/// dentro de la libreria
class SJwt{

  static String generateJWT({required String mail, String? customSecureKey}){
    String token;

    final jwt = JWT(
      {
        'mail': mail
      },
      issuer: 'JhonaCode',
    );

    token = jwt.sign(SecretKey( customSecureKey ?? SEnviromentData.jwtSecretKey), expiresIn: Duration(days: 15));

    return token;
  }


  /// Esta funcion regresa la consulta del estado del jwt, en este caso falso para que no es valido o un error
  /// Para una jwt valida reporta fecha de vencimiento, responsable del sistema y el correo del que envia.
  static Map<String, dynamic> verifyUser({required String token, String? customSecureKey}){


    {
      try {

        JWT.verify(token, SecretKey( customSecureKey ?? SEnviromentData.jwtSecretKey ));

      } on JWTExpiredError {

        return { "response": false };

      } on JWTError catch (ex) {

        Logs.error(title: "JWT", msm: ex.message);

        return { "response": false };

      }
    }
    return { "response": true };

  }



}