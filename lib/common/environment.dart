import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";

  static String get supabaseUrl =>
      dotenv.env['SUPABASE_URL'] ?? 'SUPABASE_URL is not defined';
  static String get supabaseKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'SUPABASE_ANON_KEY is not defined';
}
