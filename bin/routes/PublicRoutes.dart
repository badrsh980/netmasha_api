import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/user/getAllProductsHandler.dart';

class PublicRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("UserRoutes");
      })
      ..post('/get_all_products', getAllProductsHandlerHandler);

    final pipeline = Pipeline().addHandler(appRoutes);
    return pipeline;
  }
}
