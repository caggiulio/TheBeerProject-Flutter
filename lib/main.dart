import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/BeerDetail.dart';
import 'API.dart';
import 'Beer.dart';
import 'BeerListItem.dart';
import 'RandomBeer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.blueGrey.shade800,
          backgroundColor: Colors.blueGrey.shade800,
          textTheme: Typography.whiteCupertino),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final API api = new API();

  Beer selectedBeer;
  bool isSearching;
  TextEditingController searchController;
  String queryName = "";

  @override
  void initState() {
    super.initState();
    isSearching = false;
    searchController = TextEditingController();
    searchController.addListener(() {
        setState(() {
          this.queryName = searchController.text;
          api.fetchedBeers.clear();
        });
    });
  }

  void _onTapRow(Beer data) {
    selectedBeer = data;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new BeerDetail(data: selectedBeer);
        });
  }

  int page = 1;
  bool loadMore = false;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (!api.isBusy &&
          !api.noMoreBeers &&
          _scrollController.position.axisDirection == AxisDirection.down &&
          _scrollController.position.pixels /
                  _scrollController.position.maxScrollExtent >
              0.8) {
        setState(() {
          loadMore = true;
        });
      }
      //print("La posizione attuale è: ${_scrollController.position}");
    });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              if (isSearching == false) {
                setState(() {
                  isSearching = true;
                });
              } else {
                setState(() {
                  isSearching = false;
                });
              }
            },
          ),
          title: isSearching ? TextField(
            controller: searchController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
          ) : Text("The Beer Project®")
      ),
      body:
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  child: RandomBeer(api: api, onTapFunc: _onTapRow)
                ),
                Flexible(
                    child: FutureBuilder<List<Beer>>(
                      future: api.fetchBeers(page + (loadMore ? 1 : 0), queryName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (loadMore) {
                            print("page from $page to ${page + 1}");
                            page++;
                            loadMore = false;
                          }
                          return Container(
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data.length + (api.noMoreBeers ? 0 : 1),
                                // ignore: missing_return
                                itemBuilder: (BuildContext context, i) {
                                  return i >= snapshot.data.length
                                      ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            child: CircularProgressIndicator())
                                      ])
                                      : new BeerListItem(
                                    data: snapshot.data[i],
                                    onTapCell: () {
                                      _onTapRow(snapshot.data[i]);
                                    },
                                    i: i,
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
                    ),
                )

              ],
            )
          )

    );
  }
}
