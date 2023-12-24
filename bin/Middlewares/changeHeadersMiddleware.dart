
import 'package:shelf/shelf.dart';


Middleware changeHeadersMiddleware() => (innerHandler) => (Request req) async {
      return innerHandler(req);
    };
