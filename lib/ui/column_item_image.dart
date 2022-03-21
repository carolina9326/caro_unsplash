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
  bool _more = false;
  bool _isLoading = false;

  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() async {
    _isLoading = true;
    int page = (_picList.length % 10) + 1;
    var value = await widget.picData.getPhotos(page: page);
    setState(() {
      _picList = value;
      int v = _picList.length ~/ 2;
      int vp = _picList.length % 2;
      _itemCount = v + vp;
      _twoItemImageListBuild(_itemCount);
      _isLoading = false;
    });
  }

  void _twoItemImageListBuild(int itemCount) {
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

      TwoItemImage element = TwoItemImage(
          onTap: (id) {
            UnsplashModel? selectedImage = _twoItemImageMap[id];
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageDetail(
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

    _more = false;
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
          itemCount: (_more) ? _itemCount + 1 : _itemCount,
          itemBuilder: (BuildContext context, int index) {
            if (index >= _itemCount) {
              if (!_isLoading) {
                loadData();
              }
            }
            print(index);
            return _twoItemImageList[index];
          }),
    );
  }
}
