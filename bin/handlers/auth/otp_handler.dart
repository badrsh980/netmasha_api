import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';
import '../../helper/checkBody.dart';

otpHandler(Request req) async {
  try {
    final body = json.decode(await req.readAsString());

    List<String> keyNames = ["email", "otp"];
    checkBody(body: body, keysCheck: keyNames);

    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;

    user = await supabase?.auth
        .signInWithPassword(password: body["password"], email: body["email"]);

    return Response.ok(
        json.encode({
          "msg": "Login successfully",
          "token": user?.session?.accessToken,
          "refreshToken": user?.session?.refreshToken,
          "expiresAt": user?.session?.expiresAt
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
