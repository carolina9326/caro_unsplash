import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/local_image_data.dart';
import 'package:caro_unsplash/ui/image_detail.dart';
import 'package:caro_unsplash/ui/two_item_image.dart';
import 'package:flutter/material.dart';

import '../repository/pic_data.dart';

class ColumnItemImage extends StatefulWidget {
  final PicData picData;
  const ColumnItemImage({Key? key, required this.picData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnItemImage();
}

class _ColumnItemImage extends State<ColumnItemImage> {
  List<UnsplashModel> _picList = [];
  final List<TwoItemImage> _twoItemImageList = [];
  final Map<String, UnsplashModel> _twoItemImageMap = {};

  int _itemCount = 0;
  int _page = 1;
  int _nextPage = 2;
  bool _isNetwork = true;
  late ScrollController _scrollController;
  late final _key;

  @override
  void initState() {
    _key = widget.key as ValueKey;
    if (_key.value == 'home') {
      print(_isNetwork);
    }
    if (_key.value == 'fav') {
      _isNetwork = false;
    }
    widget.picData.favorites.addListener(() {
      if (widget.picData.favorites.isAdded) {
        //_loadData2();
        if (!_isNetwork) {
          _loadData2();
        }
      }
      //_loadData2();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(
      () async {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          print('fin');
          await _loadData2();
        }
      },
    );
    _loadData2();
    super.initState();
  }

  Future _loadData2() async {
    if (_itemCount != 0) {
      _nextPage = _itemCount + 1;
      _page = _itemCount;
    }
    while (_page < _nextPage) {
      var e = await widget.picData.getPhotos(page: _page);
      _picList.addAll(e);
      int v = _picList.length ~/ 2;
      int vp = _picList.length % 2;
      _itemCount = v + vp;
      _twoItemImageListBuild(_itemCount);

      _page++;
    }
    _nextPage++;
  }

  void _twoItemImageListBuild(int itemCount) {
    _twoItemImageList.clear();
    for (int i = 0; i < itemCount; i++) {
      int _positionL = i * 2;
      int _positionR = _positionL + 1;
      UnsplashModel picLeft = _picList[_positionL];
      _twoItemImageMap.putIfAbsent(picLeft.id, () => picLeft);
      UnsplashModel? picRigh;
      if (_positionR <= _picList.length - 1) {
        picRigh = _picList[_positionR];
        _twoItemImageMap.putIfAbsent(picRigh.id, () => picRigh!);
      }

      final TwoItemImage element = TwoItemImage(
          isNetwork: _isNetwork,
          key: ValueKey(i),
          onTap: (id) {
            UnsplashModel? selectedImage = _twoItemImageMap[id];
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageDetail(
                        isNetwork: _isNetwork,
                        favoritesNotifierModel: widget.picData.favorites,
                        picData: widget.picData,
                        model: selectedImage!,
                      )),
            );
          },
          height: MediaQuery.of(context).size.height * .4,
          left: picLeft,
          rigt: picRigh);

      _twoItemImageList.add(element);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_itemCount == 0) {
      var width = MediaQuery.of(context).size.width * .4;
      var icon = Icon(
        Icons.no_photography,
        size: width,
      );
      if (widget.picData is LocalImageData) {
        return Center(
          child: Icon(
            Icons.favorite,
            size: width,
          ),
        );
      }
      return Center(
        child: icon,
      );
    }
    return Container(
      color: Colors.black,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _itemCount,
          itemBuilder: (BuildContext context, int index) {
            return _twoItemImageList[index];
          }),
    );
  }
}
