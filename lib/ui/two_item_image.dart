import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/material.dart';

import 'item_image.dart';

class TwoItemImage extends StatelessWidget {
  final UnsplashModel left;
  final UnsplashModel? rigt;
  final double height;
  final bool isNetwork;
  final Function(String id) onTap;

  const TwoItemImage(
      {Key? key,
      required this.left,
      this.rigt,
      required this.height,
      required this.onTap,
      required this.isNetwork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: ItemImage(
            isNetwork: isNetwork,
            onTap: onTap,
            model: left,
            height: height,
          )),
      const SizedBox(
        width: 10,
      ),
      Expanded(
          flex: 1,
          child: ItemImage(
            isNetwork: isNetwork,
            onTap: onTap,
            model: rigt,
            height: height,
          ))
    ]);
  }
}
