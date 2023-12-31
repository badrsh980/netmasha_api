import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';
import '../../helper/checkBody.dart';

delExplorers(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final token = req.headers['authorization']!.split(" ").last;
    List<String> keyNames = ["email", "password", "phone", "name"];
    checkBody(body: body, keysCheck: keyNames);

    final supabase = SupabaseIntegration.instant;

    await supabase!.auth.admin;
    final UserResponse user = await supabase.auth.getUser(token);

    try {
      await supabase
          .from('explorers')
          .update(body["name"])
          .eq("uuid_auth", user.user!.id);
      body.remove("name");
      await supabase.auth.admin.updateUserById(user.user!.id,
          attributes: AdminUserAttributes(
            email: body["email"],
            phone: body["phone"],
          ));
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
