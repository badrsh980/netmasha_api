import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/experience/add_experience_handle.dart';
import '../handlers/experience/view_experince_handle.dart';

class ExperienceRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("UserRoutes");
      })
      ..post('/add', addExperienceHandler)
      ..get('/view', viewExperienceHandler);

    final pipeline = Pipeline().addHandler(appRoutes);
    return pipeline;
  }
}
