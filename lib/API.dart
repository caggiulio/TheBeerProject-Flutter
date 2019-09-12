
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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
    final response = await http.get(host + finalQuery);
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
    final response = await http.get(host + endpoint);

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
}