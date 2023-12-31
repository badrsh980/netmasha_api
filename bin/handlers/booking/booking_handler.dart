import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';
import '../../helper/checkBody.dart';

// TODO:
bookingHandler(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());
    final token = req.headers['authorization']!.split(" ").last;

    List<String> keyNames = [
      "experience_id",
      "child_numbers",
      "adult_numbers",
      "date",
    ];
    checkBody(body: body, keysCheck: keyNames);
    final supabase = SupabaseIntegration.instant;
    await supabase!.auth.admin;

    final UserResponse user = await supabase.auth.getUser(token);
    try {
      final explorersId = await supabase
          .from("explorers")
          .select("id")
          .eq("uuid_auth", user.user!.id);

      final id = <String, int>{"explorer_id": explorersId.first["id"]};

      body.addEntries(id.entries);
      await supabase.from('bookings').insert(body);
      print("done");
    } catch (error) {
      print(error);
      throw FormatException("here is error $error");
    }

    return Response.ok(json.encode({"msg": "done"}),
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
