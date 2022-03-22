import 'package:flutter/material.dart';

import 'models/unsplash_model.dart';
import 'repository/local_image_data.dart';
import 'repository/unsplash_image_data.dart';
import 'ui/column_item_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Caro Unsplash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _kHome = 'home';
  final String _kFav = 'fav';
  bool _isHome = true;
  int _selectedIndex = 0;
  late final ColumnItemImage _home;
  late final ColumnItemImage _fav;
  late final UnsplasImageData _unsplasImageData;
  late final LocalImageData _localImageData;
  late final FavoritesNotifierModel _favoritesData;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _favoritesData = FavoritesNotifierModel();
    _unsplasImageData = UnsplasImageData(favorites: _favoritesData);
    _localImageData = LocalImageData(favorites: _favoritesData);
    _home = ColumnItemImage(key: Key(_kHome), picData: _unsplasImageData);
    _fav = ColumnItemImage(key: Key(_kFav), picData: _localImageData);
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      int length = _textEditingController.text.length;

      if (length == 1) {
        _favoritesData.addSearch(false);
      }

      if (length != 0 && (length % 4) == 0) {
        _favoritesData.addTextToSearch(_textEditingController.text);
        _favoritesData.addSearch(true);
      }
    });
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _isHome = true;
      } else {
        _isHome = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                    ),
                  )),
              Expanded(
                  flex: 13,
                  child: IndexedStack(
                    index: (_isHome) ? 0 : 1,
                    children: [_home, _fav],
                  ))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_max_outlined,
                  color: Colors.white,
                ),
                label: 'Home',
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                )),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline_outlined,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              label: 'Favorites',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ));
  }
}
