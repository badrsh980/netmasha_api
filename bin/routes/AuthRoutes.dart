import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/auth/createAccountHandler.dart';
import '../handlers/auth/loginHandlers.dart';

class AuthRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("AuthRoutes");
      })
      ..post("/login", loginHandler)
      ..post("/create_account", createAccountHandler);

    return appRoutes;
  }
}
