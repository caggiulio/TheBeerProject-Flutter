import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'API.dart';
import 'Beer.dart';

class RandomBeer extends StatelessWidget {

  API api;
  Function(Beer data, int i) onTapFunc;

  RandomBeer({this.api, this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<Beer>(
          future: api.fetchRandomBeer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final randomBeer = snapshot.data;

              return GestureDetector(
                  onTap: () {
                    onTapFunc(randomBeer, 0);
                  },
                  child: Container(
                      padding: EdgeInsets.all(15.0),
                      //color: Colors.amber[200],
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.amber[200]
                      ),
                      child: Row(
                        children: <Widget>[
                          randomBeer.imageUrl != null ? Image.network(
                              randomBeer.imageUrl, fit: BoxFit.fitHeight,
                              width: 50) : Container(
                              width: 50, height: 70, color: Colors.grey[300]),
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(randomBeer.name, style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.bold)),
                                    Text(randomBeer.description,
                                        style: TextStyle(
                                            color: Colors.blueGrey[700]),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                )
                            ),
                          )
                        ],)
                  )
              );
            }
            else {
              return Container();
            }
          }
      );
  }
}