import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';

getExplorers(Request req) async {
  try {
    final token = req.headers['authorization']!.split(" ").last;
    final supabase = SupabaseIntegration.instant;

    await supabase!.auth.admin;
    final UserResponse user = await supabase.auth.getUser(token);

    final PostgrestList explorers;
    try {
      final uuid = <String, String>{"user_id": user.user!.id};

      explorers =
          await supabase.from('explorers').select().eq("uuid_auth", uuid);
    } catch (error) {
      print(error);
      throw FormatException("here is error");
    }

    return Response.ok(json.encode({"msg": explorers}),
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
