import 'package:shelf/shelf.dart';
import '../handlers/chat/addchat.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/chat/getchat.dart';

class ChatRoutes {
  Handler get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok("chat routes");
      })
      ..post("/add", addChatHandler)
      ..get("/get", GetchatHandler);
    return appRoutes;
  }
}
