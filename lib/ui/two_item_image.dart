import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/material.dart';

import 'item_image.dart';

class TwoItemImage extends StatelessWidget {
  final UnsplashModel left;
  final UnsplashModel rigt;
  final double height;

  const TwoItemImage(
      {Key? key, required this.left, required this.rigt, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Expanded(
            flex: 1,
            child: ItemImage(
              model: left,
              height: height,
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 1,
            child: ItemImage(
              model: rigt,
              height: height,
            ))
      ]),
    );
  }
}
