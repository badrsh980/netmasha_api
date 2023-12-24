import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;

  SupabaseClient get supabase {
    final supabase = SupabaseClient("https://bppfxcynxkxvpdovdfsa.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwcGZ4Y3lueGt4dnBkb3ZkZnNhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMDM3ODc2NSwiZXhwIjoyMDE1OTU0NzY1fQ.nh_Qn1eofLGxrCxdIvKbbQ5gyn_XJIFSu2mf2RMMmR4");
    instant = supabase;
    return supabase;
  }
}
