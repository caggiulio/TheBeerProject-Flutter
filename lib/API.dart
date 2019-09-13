
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Beer.dart';
import 'Food.dart';

class API {

  static final API _instance = API._internal();
  factory API() => _instance;

  API._internal() {
    // init things inside this
  }

  final beerApiHost = 'https://api.punkapi.com/v2/';

  final foodApiHost = 'https://trackapi.nutritionix.com/v2/';
  final foodApiHeaders = {
    'x-app-id': 'f7193d7d',
    'x-app-key': 'd04238753bd14759b0ca06caaf7700b2',
    'x-remote-user-id': '0'
  };

  List<Beer> fetchedBeers = new List<Beer>();
  bool noMoreBeers = false;
  bool isBusy = false;
  int lastCallId = 0;

  void resetBeersList() {
    fetchedBeers.clear();
    noMoreBeers = false;
  }


  Future<List<Beer>> fetchBeers(int page, String query, String malt) async {
    int myCallId = ++lastCallId;
    isBusy = true;
    var finalQuery = "beers?page=$page";
    if (query.isNotEmpty) {
      finalQuery = finalQuery + "&beer_name=$query";
    }
    if (malt.isNotEmpty) {
      finalQuery = finalQuery + "&malt=$malt";
    }
    final response = await http.get(beerApiHost + finalQuery);
    isBusy = false;
    if (lastCallId == myCallId) {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        final beers = (json.decode(response.body) as List).map((singleJson) =>
            Beer.fromJson(singleJson)).toList();
        if (beers.length > 0) {
          fetchedBeers.addAll(beers);
        } else {
          noMoreBeers = true;
        }
        return fetchedBeers;
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    }
  }

  Future<Beer> fetchRandomBeer() async {
    final endpoint = "beers/random";
    final response = await http.get(beerApiHost + endpoint);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final beers = (json.decode(response.body) as List).map((singleJson) =>
          Beer.fromJson(singleJson)).toList();
      return beers.first;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Food>> searchFood(String text) async {
    final endpoint = "search/instant?query=$text";
    final response = await http.get(foodApiHost + endpoint, headers: foodApiHeaders);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final resJson = (json.decode(response.body) as Map<String, dynamic>);
      final foods = (resJson["common"] as List).map((foodJson) =>
          Food.fromJson(foodJson)
      ).toList();

      return foods;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load food');
    }
  }
}