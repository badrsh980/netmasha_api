import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';
import '../../helper/checkBody.dart';

convertToServiceProviderHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    List<String> keyNames = ["commercial_record", "city"];

    checkBody(body: body, keysCheck: keyNames);

    final supabase = SupabaseIntegration.instant;
    AuthResponse? user;

    await supabase!.auth.admin;

    try {
      final uuid = <String, String>{"uuid_auth": user!.user!.id};
      body.addEntries(uuid.entries);

      await supabase.from('explorers').insert(body);
    } catch (error) {
      print(error);
      throw FormatException("here is error");
    }

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
