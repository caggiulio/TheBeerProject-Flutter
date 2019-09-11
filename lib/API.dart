
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Beer.dart';

class API {

  static final API _instance = API._internal();
  factory API() => _instance;

  API._internal() {
    // init things inside this
  }

  final host = 'https://api.punkapi.com/v2/';

  List<Beer> fetchedBeers = new List<Beer>();

  Future<List<Beer>> fetchBeers(int page) async {
    final response = await http.get(host+"beers?page=$page");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final beers = (json.decode(response.body) as List).map((singleJson) => Beer.fromJson(singleJson)).toList();
      fetchedBeers.addAll(beers);
      return fetchedBeers;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}