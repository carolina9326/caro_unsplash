import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final UnsplashModel? model;
  final bool isNetwork;
  final double height;
  final Function(String id) onTap;

  const ItemImage(
      {Key? key,
      this.model,
      this.isNetwork = true,
      required this.height,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model is! UnsplashModel) {
      return SizedBox(
        height: height,
      );
    }
    late ImageProvider imageProvider;
    late ImageProvider imageProviderProfile;
    late CachedNetworkImage imageNetwork;
    late CachedNetworkImage imageNetworkProfile;
    if (isNetwork) {
      imageNetwork = CachedNetworkImage(
        imageUrl: model!.urls.full,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
      imageNetworkProfile = CachedNetworkImage(
        imageUrl: model!.user.profileImage.medium,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      var file = File(model!.urls.thumb);
      var fileProfile = File(model!.user.profileImage.medium);
      imageProvider = FileImage(file);
      imageProviderProfile = FileImage(fileProfile);
    }
    return GestureDetector(
      onTap: () => onTap(model!.id),
      child: Container(
        padding: const EdgeInsets.all(15),
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
            Expanded(
                flex: 7,
                child:
                    (isNetwork) ? imageNetwork : Image(image: imageProvider)),
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
                        child: (isNetwork)
                            ? imageNetworkProfile
                            : Image(image: imageProviderProfile))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
