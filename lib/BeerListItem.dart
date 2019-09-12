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
    return data == null
        ? Container()
        : Column(children: <Widget>[
            InkWell(
              highlightColor: Colors.blueGrey.shade900,
              splashColor: Colors.blueGrey.shade900,
              //behavior: HitTestBehavior.translucent,
              onTap: onTapCell,
              child: Container(
                padding:
                    EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: data.imageUrl == null
                          ? Container()
                          : Image.network(data.imageUrl,
                          fit: BoxFit.fitHeight,
                          height: 125,
                          alignment: Alignment.center),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data.name,
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            data.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
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
