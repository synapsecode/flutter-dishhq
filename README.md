# DishHQ for flutter

Dish makes shipping software productive by managing all the hassle of building, shipping and managing software so your team can focus on the core product and forget the hassle.
This package is a wrapper for the official DishHQ Rest API
Learn more [here](https://dishhq.xyz/)

## Install

Add this line to your **pubspec.yaml**:
```yaml
dependencies:
  dishhq: ^0.0.1
```

Then run this command:
```bash
$ flutter packages get
```

Then add this import:
```dart
import 'package:dishhq/dishhq.dart';
```

## Supported Platforms
- Android
- iOS
- macOS
- Web (Not working due to CORS Issues)

# Usage (KVDatabase)

```dart
//Import dish
import 'package:dishhq/dishhq.dart';

// Inside Stateful Widget, Initialize Dish KVDatabase Instance
var db = Dish.database(apiKey: '<YOUR_API_KEY>');

//Use the provided methods in your code

Map res = await db.create(
    key: 'yourkey',
    value: 'yourvalue', 
); //Create Method

Map res = await db.update(
    key: 'yourkey',
    value: 'yourvalue', 
); //Update Method

Map res = await db.read(key:'yourkey'); //Read Method

Map res = await db.delete(key: 'yourkey'); //Delete Method

/*
Each of these functions is a future that once resolved, returns a Map that looks like:
{
    "success": bool,  (if false => An API Error has definitely occured)
    "message": String? (Usually contains the specific error message) | nullable
    "value": String? (Contains the returned value Read Reqeusts) | nullable
}
NOTE: If value is null in a read request then check the message property of the response to check for errors
*/
```