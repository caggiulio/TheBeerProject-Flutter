import 'package:flutter/material.dart';

import 'API.dart';
import 'Food.dart';
import 'FoodListItem.dart';

class FoodSearch extends StatelessWidget {
  const FoodSearch({Key key, this.api})
      : super(key: key);

  final API api;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(future: api.searchFood("chicken"), builder: (BuildContext buildContext, AsyncSnapshot<List<Food>> snapshot) {

      if (snapshot.hasData) {
            return Container(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              // ignore: missing_return
              itemBuilder: (BuildContext context, i) {
                return FoodListItem(food: snapshot.data[i]);
              }),
        );
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      }
      else {
        return Container();
      }
    });
  }
}