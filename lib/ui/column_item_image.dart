import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/ui/two_item_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ColumnItemImage extends StatefulWidget {
  const ColumnItemImage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnItemImage();
}

class _ColumnItemImage extends State<ColumnItemImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return TwoItemImage(
                height: MediaQuery.of(context).size.height * .4,
                left: UnsplashModel.fakeData(),
                rigt: UnsplashModel.fakeData());
          }),
    );
  }
}
