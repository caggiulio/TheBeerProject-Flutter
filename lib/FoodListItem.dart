import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Food.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({Key key, this.food})
      : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    return food == null
        ? Container()
        : Text(food.name);
  }
}
