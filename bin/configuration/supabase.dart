import 'package:supabase/supabase.dart';

class SupabaseIntegration {
  static SupabaseClient? instant;

  SupabaseClient get supabase {
    final supabase = SupabaseClient("https://nxwtvllaffmfybyvyzuc.supabase.co",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im54d3R2bGxhZmZtZnlieXZ5enVjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMjk5Mjk4MiwiZXhwIjoyMDE4NTY4OTgyfQ.PfhjIZ0lKRA_YPgbLcH3PtPzCiaTp7g45f8eP_n539A");
    instant = supabase;
    return supabase;
  }
}
