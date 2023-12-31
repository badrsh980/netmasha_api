import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middlewares/checkTokenMiddleware.dart';
import '../handlers/explorers/del_explorers_Handler.dart';
import '../handlers/explorers/get_explorers_Handler.dart';

class UserRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("UserRoutes");
      })
      ..get('/get_user', getExplorers)
      ..delete('/del_user', delExplorers);

    final pipeline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(appRoutes);
    return pipeline;
  }
}
