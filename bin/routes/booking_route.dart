import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BookingRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      .get("/", (Request req) {
        return Response.ok("UserRoutes");
      });
    final pipeline = Pipeline().addHandler(appRoutes);
    return pipeline;
  }
}
