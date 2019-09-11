import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Beer.dart';

class BeerListItem extends StatelessWidget {
  const BeerListItem({
    Key key, this.snapshot, this.onTapCell
  }) : super(key: key);

  final AsyncSnapshot<List<Beer>> snapshot;
  final Function onTapCell;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: ListView.builder(
          itemCount: snapshot.data.length,
          // ignore: missing_return
          itemBuilder:  (BuildContext context, i) {
            return Container(
              child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: onTapCell,

                      child: Row(
                        children: <Widget>[

                          Expanded(
                            flex: 5,
                            child: Image.network(snapshot.data[i].imageUrl,
                                fit: BoxFit.fitHeight,
                                height: 300,
                                width: 100,
                                alignment: Alignment.center),
                          ),

                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data[i].name, style:
                                TextStyle(
                                    fontSize: 30
                                ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(snapshot.data[i].description),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      color: Colors.grey,
                      indent: 30,
                    ),

                    SizedBox(
                      width: 0,
                      height: 50,
                    )
                  ]
              ),
            );
          }
      ),
    );
  }
}
