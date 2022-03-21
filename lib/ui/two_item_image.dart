import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/widgets.dart';

import 'item_image.dart';

class TwoItemImage extends StatelessWidget {
  final UnsplashModel left;
  final UnsplashModel rigt;

  const TwoItemImage({Key? key, required this.left, required this.rigt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: ItemImage(model: left)),
        Expanded(flex: 1, child: ItemImage(model: rigt))
      ],
    );
  }
}
