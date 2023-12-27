import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/favorite/add_favotite_handler.dart';
import '../handlers/favorite/remove_favorite_handler.dart';
import '../handlers/favorite/view_favorite_handler.dart';

class FavoriteRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("UserRoutes");
      })
      ..post('/add', addFavoriteHandler)
      ..post('/remove', removeFavoriteHandler)
      ..get('/view', viewFavoriteHandler);

    final pipeline = Pipeline().addHandler(appRoutes);
    return pipeline;
  }
}
