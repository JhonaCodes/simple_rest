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

import 'package:simple_rest/simple_rest.dart';
import 'controller/school_controller.dart';

void main() {
  Router app = Router();
  SServer server = SServer();

  server.start(
    port: 9080,
    isRouterControlActive: false,
    app: app,
    controllerList: [SchoolController],
  );

}
