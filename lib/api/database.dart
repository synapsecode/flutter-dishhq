import 'dart:convert';
import 'package:dishhq/dishhq.dart';
import 'package:http/http.dart' as http;

class KVDatabase {
  String apiKey = '0x00000000000000000';
  KVDatabase({this.apiKey});

  // KeyValueStore
  Future<Map> dbrequest({
    Map data,
    String method,
    String endpoint,
    String apiKey,
  }) async {
    // ReturnValues
    bool status = false;
    String returnValue;
    String message;
    http.Response resp;
    if (method == 'POST') {
      resp = await http.post(
        Uri.parse('${Dish.apiURL}/db/$endpoint'),
        headers: {
          "X-Dish-Key": apiKey,
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );
    } else {
      //Converting data into query params
      String queryParams = '';
      data.forEach((k, v) => queryParams += '$k=$v&');
      queryParams = queryParams.substring(0, queryParams.length - 1);
      //Sending GET Request
      resp = await http.get(
        Uri.parse('${Dish.apiURL}/db/$endpoint?$queryParams'),
        headers: {
          'X-Dish-Key': apiKey,
        },
      );
    }
    if (resp.statusCode == 200) {
      Map decodedResponse = jsonDecode(resp.body);
      // print(decodedResponse);
      if (decodedResponse['error']) {
        print(
          "Dish::KeyValueStoreAPI @ ${endpoint.toUpperCase()} Error: ${decodedResponse['message']}",
        );
        message = decodedResponse['message'] ??
            'Unexpected Error @ ${endpoint.toUpperCase()} Endpoint';
        status = false;
      }
      status = true;
      returnValue = decodedResponse['value'];
    } else {
      message = "Unexpected Error Occured: (${resp.statusCode})";
      try {
        print(json.decode(resp.body));
      } catch (e) {}
    }
    return {
      'success': status,
      'value': returnValue,
      'message': message,
    };
  }

  Future<Map> create({String key, dynamic value}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {
        'key': key,
        'value': value,
      },
      endpoint: 'create',
      method: 'POST',
    );
  }

  Future<Map> read({String key}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {'key': key},
      endpoint: 'read',
      method: 'GET',
    );
  }

  Future<Map> update({String key, dynamic value}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {'key': key, 'value': value},
      endpoint: 'update',
      method: 'POST',
    );
  }

  Future<Map> delete({String key}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {'key': key},
      endpoint: 'delete',
      method: 'GET',
    );
  }
}
