import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/service_provider/convert_to_service_provider.dart';
import '../handlers/auth/createAccountHandler.dart';
import '../handlers/auth/loginHandlers.dart';
import '../handlers/auth/otp_handler.dart';

class AuthRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("AuthRoutes");
      })
      ..post("/login", loginHandler)
      ..post("/create_account", createAccountHandler)
      ..post("/convert_To_Service_Provider", convertToServiceProviderHandler)
      ..post("/otp", otpHandler);

    return appRoutes;
  }
}
