import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';
import '../../helper/checkBody.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    List<String> keyNames = [
      "email",
      "password",
      "phone",
      "name",
    ];

    checkBody(body: body, keysCheck: keyNames);

    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;

    await supabase!.auth.admin
        .createUser(AdminUserAttributes(
            email: body["email"],
            password: body["password"],
            emailConfirm: true))
        .then((value) async {
      try {
        user = await supabase.auth.signInWithPassword(
            password: body["password"], email: body["email"]);
        final uuid = <String, String>{"uuid_auth": user!.user!.id};
        body.remove("email");
        body.remove("phone");
        body.remove("password");
        body.addEntries(uuid.entries);
        await supabase.from('explorers').insert(body);
      } catch (error) {
        print(error);
        throw FormatException("here is error");
      }
    });

    return Response.ok(
        json.encode({
          "token": user!.session?.accessToken,
          "refreshToken": user!.session?.refreshToken,
          "expires_at": user!.session?.expiresAt
        }),
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