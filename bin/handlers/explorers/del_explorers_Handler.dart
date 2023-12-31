import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';

delExplorers(Request req) async {
  try {
    final token = req.headers['authorization']!.split(" ").last;
    final supabase = SupabaseIntegration.instant;

    await supabase!.auth.admin;
    final UserResponse user = await supabase.auth.getUser(token);

    try {
      await supabase.from('explorers').delete().eq("uuid_auth", user.user!.id);
      await supabase.auth.admin.deleteUser(user.user!.id);
    } catch (error) {
      throw FormatException("here is error$error");
    }

    return Response.ok(json.encode({"msg": "Acc has del"}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response(int.parse(error.statusCode.toString()),
        body: error.message);
  } on PostgrestException catch (error) {
    String msgError = '';
    if (error.code == "PGRST204") {
      msgError = "there is error with password";
    }
    return Response.badRequest(body: msgError);
  } catch (error) {
    return Response.badRequest(body: error.toString());
  }
}
