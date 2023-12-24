import 'package:shelf/shelf.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

Middleware checkTokenMiddleware() => (innerHandler) => (Request req) async {
      try {
        if (req.headers["authorization"] == null) {
          return Response.unauthorized("no authorized");
        }
        final token = req.headers["authorization"]?.split(" ")[1];
        print(token);
        final jwt = JWT.verify(
            token!,
            SecretKey(
                'RQ4cbokpJ3tAlFdUMb5w8Hs3JTOrGgza2FgXEHatmEJo+/wuAt7Qq65EuIW97LVkSuttnupy86aGXlPLOR3Qrg=='));

        final jwtData = JWT.decode(token);
        print(jwtData.subject);
        print(jwtData.jwtId);
        return innerHandler(req);
      } catch (error) {
        print(error);
        return Response.unauthorized("no authorized");
      }
    };
