library dishhq;

import 'sdk/database.dart';

class Dish {
  //Constants
  static const String apiURL = 'https://api.dishhq.xyz';

  //Static SDK Elements

  ///Gives you access to KVDatabase from the DishSDK. Easiest way to store data.
  static KVDatabase database({String apiKey}) => KVDatabase(apiKey: apiKey);

  ///A Class that contains static methods for all the SDKs provided by Dish
  Dish();
}
