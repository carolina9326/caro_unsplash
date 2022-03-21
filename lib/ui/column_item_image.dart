import 'package:caro_unsplash/models/unsplash_model.dart';
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
  List<UnsplashModel> picList = [];
  int _itemCount = 0;

  @override
  void initState() {
    widget.picData.getPhotos(page: 1).then((value) {
      setState(() {
        picList = value;
        int v = picList.length ~/ 2;
        int vp = picList.length % 2;
        _itemCount = v + vp;
      });
    });
    //picList = widget.picData.getPhotos(page: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_itemCount == 0) {
      return const Icon(Icons.no_photography);
    }
    return Container(
      color: Colors.black,
      child: ListView.builder(
          itemCount: _itemCount,
          itemBuilder: (BuildContext context, int index) {
            int _positionL = index * 2;
            int _positionR = _positionL + 1;
            var picLeft = picList[_positionL];
            UnsplashModel? picRigh;
            if (_positionR <= picList.length - 1) {
              picRigh = picList[_positionR];
            }
            return TwoItemImage(
                height: MediaQuery.of(context).size.height * .4,
                left: picLeft,
                rigt: picRigh);
          }),
    );
  }
}
