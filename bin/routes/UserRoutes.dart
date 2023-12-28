import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middlewares/checkTokenMiddleware.dart';
import '../handlers/user/createPostHandler.dart';
import '../handlers/user/get_all_user_Handler.dart';

class UserRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("UserRoutes");
      })
      ..post('/create_post', createPostHandler)
      ..get('/get_user', getExplorers);

    final pipeline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(appRoutes);
    return pipeline;
  }
}
