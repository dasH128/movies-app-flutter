import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String theMobieDbApiKey = dotenv.env['THE_MOBIEDB_API_KEY'] ?? 'ZzzZ';
}
