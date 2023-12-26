import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';
import '../../helper/checkBody.dart';

createAccountHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    List<String> keyNames = ["email", "password", "phone", "name"];

    checkBody(body: body, keysCheck: keyNames);
    AuthResponse? user;

    final supabase = SupabaseIntegration.instant;

    await supabase!.auth.admin
        .createUser(AdminUserAttributes(
      email: body["email"],
      password: body["password"],
    ))
        .then((value) async {
      try {
        await supabase.auth.resend(type: OtpType.signup, email: body["email"]);
        body.remove("email");
        body.remove("phone");
        body.remove("password");
        final uuid = <String, String>{"uuid_auth": user!.user!.id};
        body.addEntries(uuid.entries);
        await supabase.from('explorers').insert(body);
      } catch (error) {
        print(error);
        throw FormatException("here is error");
      }
    });

    return Response.ok(json.encode({'msg': 'otp has been sent to your email'}),
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
