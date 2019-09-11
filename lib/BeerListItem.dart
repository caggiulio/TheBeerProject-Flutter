import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Beer.dart';

class BeerListItem extends StatelessWidget {
   const BeerListItem({Key key, this.data, this.onTapCell, this.i})
      : super(key: key);

  final Beer data;
  final Function onTapCell;
  final int i;

  @override
  Widget build(BuildContext context) {
    return data == null ? Container() : Column(children: <Widget>[
      GestureDetector(
        onTap: onTapCell,
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: data.imageUrl == null ? Container() : Image.network(data.imageUrl,
                    fit: BoxFit.fitHeight,
                    height: 300,
                    width: 100,
                    alignment: Alignment.center),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.name,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.left,
                    ),
                    Text(data.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Divider(
        color: Colors.grey,
        indent: 30,
      ),
    ]);
  }
}
