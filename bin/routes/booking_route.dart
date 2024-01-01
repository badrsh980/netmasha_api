import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/booking/booking_handler.dart';
import '../handlers/booking/get_booking_handler.dart';

class BookingRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("booking routes");
      })
      ..post("/post", bookingHandler)
      ..get("/get", GetbookingHandler);
    return appRoutes;
  }
}
