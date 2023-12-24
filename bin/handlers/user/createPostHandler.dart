import 'package:shelf/shelf.dart';

import '../../configuration/supabase.dart';

createPostHandler(Request req) async {
  final token = req.headers["authorization"]?.split(" ")[1];
  final user = await SupabaseIntegration.instant?.auth.getUser(token);
  return Response.ok(user?.user?.id.toString());
}
