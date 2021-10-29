import 'package:dishhq/api/database.dart';
import '../dishhq.dart';

KVDatabase db = Dish.database(apiKey: 'atharvaJ0MKCG2');

Future<List<Map>> testDishAPIWrapper() async {
  // Initialize
  Map c = await db.create(key: 'testUser', value: 'Manas'); //Create
  Map r1 = await db.read(key: 'testUser'); // Read(1) - TestCreate
  Map u = await db.update(key: 'testUser', value: 'Manas'); // Update
  Map r2 = await db.read(key: 'testUser'); // Read(2) - TestUpdate
  Map d = await db.delete(key: 'testUser'); //Delete
  Map r3 = await db.read(key: 'testUser'); // Read(3) - TestDelete
  //Note: Returns { success: bool, value: dynamic?, message: String? }
  //message also carries the error message if present
  return [c, r1, u, r2, d, r3];
}

void main() async {
  print("DishRestAPIWrapperTest Start");
  List<Map> x = await testDishAPIWrapper();
  print("Outputs");
  x.forEach((e) {
    print(e);
  });
  print("DishRestAPIWrapperTest Done");
}
