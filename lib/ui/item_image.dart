import 'dart:io';

import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/widgets.dart';

class ItemImage extends StatelessWidget {
  final String authorName;
  final bool isNetwork;
  final String pathImage;

  const ItemImage(
      {Key? key,
      required this.authorName,
      this.isNetwork = true,
      required this.pathImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (isNetwork) {
      imageProvider = NetworkImage(pathImage);
    } else {
      var file = File(pathImage);
      imageProvider = FileImage(file);
    }
    return Column(
      children: [
        Text(authorName),
        Image(image: imageProvider),
      ],
    );
  }
}
