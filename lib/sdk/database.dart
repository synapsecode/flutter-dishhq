import 'dart:convert';
import 'package:dishhq/dishhq.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KVDatabase {
  String apiKey = '0x00000000000000000';

  ///KVDatabase is a class that allows you to interact with Dish's Key Value
  ///Database API easily! It contains familiar functions that handle all the
  ///important tasks associated with performing any database operations.
  ///[apiKey] is your API Key
  KVDatabase({@required this.apiKey});

  ///This function generates database requests
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

  ///Performs a create request in your Dish Database
  ///Returns a future that resolves to a Map.
  Future<Map> create({@required String key, @required dynamic value}) async {
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

  ///Performs a read request in your Dish Database
  ///Returns a future that resolves to a Map.
  Future<Map> read({@required String key}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {'key': key},
      endpoint: 'read',
      method: 'GET',
    );
  }

  ///Performs a update request in your Dish Database
  ///Returns a future that resolves to a Map.
  Future<Map> update({@required String key, @required dynamic value}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {'key': key, 'value': value},
      endpoint: 'update',
      method: 'POST',
    );
  }

  ///Performs a delete request in your Dish Database
  ///Returns a future that resolves to a Map.
  Future<Map> delete({@required String key}) async {
    return await dbrequest(
      apiKey: apiKey,
      data: {'key': key},
      endpoint: 'delete',
      method: 'GET',
    );
  }
}
