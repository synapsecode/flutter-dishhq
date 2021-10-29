library dishhq;

import 'api/database.dart';

class Dish {
  static const String apiURL = 'https://api.dishhq.xyz';
  static KVDatabase database({String apiKey}) => KVDatabase(apiKey: apiKey);
}
