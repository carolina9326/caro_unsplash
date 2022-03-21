import 'dart:io';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final UnsplashModel? model;
  final bool isNetwork;
  final double height;

  const ItemImage(
      {Key? key, this.model, this.isNetwork = true, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model is! UnsplashModel)
      return SizedBox(
        height: height,
      );
    ImageProvider imageProvider;
    ImageProvider imageProviderProfile;
    if (isNetwork) {
      imageProvider = NetworkImage(model!.urls.full);
      imageProviderProfile = NetworkImage(model!.user.profileImage.medium);
    } else {
      var file = File(model!.urls.thumb);
      var fileProfile = File(model!.user.profileImage.medium);
      imageProvider = FileImage(file);
      imageProviderProfile = FileImage(fileProfile);
    }
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.black,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                model!.user.name,
                style: const TextStyle(color: Colors.white),
              )),
          Expanded(flex: 7, child: Image(image: imageProvider)),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Likes: ${model!.likes}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(image: imageProviderProfile),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
