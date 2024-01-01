import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/messages/addmessages.dart';

class MassageRoutes {
  Handler get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok("chat routes");
      })
      ..post("/post", messagesHandler);
    return appRoutes;
  }
}
