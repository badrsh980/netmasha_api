import 'package:shelf/shelf.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Middleware checkTokenMiddleware() => (innerHandler) => (Request req) async {
      try {
        if (req.headers["authorization"] == null) {
          return Response.unauthorized("no authorized");
        }
        final token = req.headers["authorization"]?.split(" ")[1];
        print(token);
        JWT.verify(
            token!,
            SecretKey(
                'oJVdT9Zs695KAP/OnTpzYcR6B6wI9F//n7I7G91endgR+obryG5b8gtSkPhpWDuBdNtbII3h8q1wtWf6o4eyKg=='));

        final jwtData = JWT.decode(token);
        print(jwtData.subject);
        print(jwtData.jwtId);
        return innerHandler(req);
      } catch (error) {
        print(error);
        return Response.unauthorized("no authorized");
      }
    };
