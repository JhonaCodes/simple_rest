/// ****************************************************
///                                                    *
///               By: JhonaCode                        *
///               Web:     https://jhonacode.com       *
///               Email:   jhonacode2020@gmail.com     *
///               Twitter: @jhonacode                  *
///               Facebook: @jhonacode                 *
///               Telegram: @jhonacode                 *
///               March 2023                           *
///                                                    *
///         Licensed under the MIT License             *
///                                                    *
/// ****************************************************

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../utils/s_enviroment_data.dart';
import '../utils/s_logs.dart';

/// This class handles JWT management, including generation and verification.
/// The [generateJWT] and [verifyUser] methods can be used to generate and verify JWTs, respectively.
/// Custom data can be added to the JWT or default values can be used.
/// Optional values can be configured in the [.env] file within the library.
class SJwt{

  static String generateJWT({required Map<String, dynamic> jwtUserInfo, String? customSecureKey, Duration? duration,String? issuer}){
    String token;
    /// Here we can establish the data that we want to be added to our [jwt].
    final jwt = JWT(
      jwtUserInfo,
      issuer: issuer ?? 'JhonaCode',
    );

    /// We set the signature of our [jwt] using our custom key or the one we generated using []
    token = jwt.sign(SecretKey( customSecureKey ?? SEnviromentData.jwtSecretKey()), expiresIn: duration ?? Duration(days: 15));

    return token;
  }


  /// This function returns the state of the jwt query, in this case false indicating it's not valid or an error.
  /// For a valid jwt, it reports expiration date, system responsible, and sender's email.
  static Map<String, dynamic> verifyUser({required String token, String? customSecureKey}){

      
    JWT.verify(token, SecretKey( customSecureKey ?? SEnviromentData.jwtSecretKey() ));

      Logs.simpleInfo(title: "JWT", msm: "User Validated");
      return { "response": true };

  }

}