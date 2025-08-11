import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvManager {
  static const String _imageBaseUrl = 'IMAGE_BASE_URL';
  static String get imageBaseUrl => dotenv.get(_imageBaseUrl);
}
