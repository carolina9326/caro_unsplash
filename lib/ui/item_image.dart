import 'dart:io';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final UnsplashModel model;
  final bool isNetwork;

  const ItemImage({
    Key? key,
    required this.model,
    this.isNetwork = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    ImageProvider imageProviderProfile;
    if (isNetwork) {
      imageProvider = NetworkImage(model.urls.full);
      imageProviderProfile = NetworkImage(model.user.profileImage.medium);
    } else {
      var file = File(model.urls.thumb);
      var fileProfile = File(model.user.profileImage.medium);
      imageProvider = FileImage(file);
      imageProviderProfile = FileImage(fileProfile);
    }
    return Container(
      color: const Color(0xFF4EA5D9),
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            model.user.name,
            style: TextStyle(color: Colors.white),
          ),
          Image(image: imageProvider),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Likes: ${model.likes}',
                style: TextStyle(color: Colors.white),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(image: imageProviderProfile),
              )
            ],
          )
        ],
      ),
    );
  }
}
