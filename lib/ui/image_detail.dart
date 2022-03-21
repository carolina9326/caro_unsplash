import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/pic_data.dart';

class ImageDetail extends StatefulWidget {
  final UnsplashModel model;
  final bool isNetwork;
  final PicData picData;
  final FavoritesNotifierModel favoritesNotifierModel;
  const ImageDetail(
      {Key? key,
      required this.model,
      this.isNetwork = true,
      required this.picData,
      required this.favoritesNotifierModel})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ImageDetail();
}

class _ImageDetail extends State<ImageDetail> {
  IconData? _favIcon;
  bool? _isFavorite;

  @override
  void initState() {
    _favIcon = Icons.favorite_border_outlined;
    _isFavorite = !widget.isNetwork;

    SharedPreferences.getInstance().then((value) {
      setState(() {
        _isFavorite = value.getBool('f${widget.model.id}') ?? false;
        _favIcon = (_isFavorite!) ? Icons.favorite : Icons.featured_video;
      });
    });
    super.initState();
  }

  void _putFavorite() async {
    if (!_isFavorite!) {
      _favIcon = Icons.favorite;
      _isFavorite = true;
      widget.favoritesNotifierModel.addFavorite(_isFavorite!);
      var isSave = await widget.picData.downloadPhoto(widget.model);
      print(isSave);
    } else {
      _favIcon = Icons.favorite_sharp;
      _isFavorite = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(color: Colors.white);
    late ImageProvider imageProvider;
    late CachedNetworkImage imageNetworkProfile;
    late CachedNetworkImage imageNetwork;
    imageNetworkProfile = CachedNetworkImage(
      imageUrl: widget.model.user.profileImage.medium,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
    if (widget.isNetwork) {
      imageNetwork = CachedNetworkImage(
        imageUrl: widget.model.urls.full,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      var file = File(widget.model.urls.full);
      imageProvider = FileImage(file);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle imagen'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: (widget.isNetwork)
                  ? imageNetwork
                  : Image(image: imageProvider),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imageNetworkProfile,
                ),
                Text(
                  'Autor: ${widget.model.user.name}',
                  style: textStyle,
                ),
                Text(
                  'Likes: ${widget.model.likes}',
                  style: textStyle,
                ),
                Text(
                  '@: ${widget.model.user.userName}',
                  style: textStyle,
                ),
              ],
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _putFavorite();
                  });
                },
                child: Icon(
                  _favIcon,
                  color: Colors.white,
                  size: 80,
                ))
          ],
        ),
      ),
    );
  }
}
