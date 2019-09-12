import 'package:flutter/material.dart';

import 'Beer.dart';

class BeerDetail extends StatelessWidget {
  const BeerDetail({Key key, this.data, this.i})
      : super(key: key);

  final Beer data;
  final int i;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: Colors.blueGrey.shade800,
      padding: EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: data.imageUrl == null ? Container() :
            Image.network(data.imageUrl,
                fit: BoxFit.fitHeight,
                height: 300,
                width: 100,
                alignment: Alignment.center),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
    );
  }
}
/*MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.blueGrey.shade800,
          textTheme: Typography.whiteCupertino),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}*/
