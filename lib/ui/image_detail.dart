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
  const ImageDetail(
      {Key? key,
      required this.model,
      this.isNetwork = true,
      required this.picData})
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
        _favIcon =
            (_isFavorite!) ? Icons.favorite : Icons.favorite_border_outlined;
      });
    });
    super.initState();
  }

  void _putFavorite() async {
    if (!_isFavorite!) {
      _favIcon = Icons.favorite;
      _isFavorite = true;
      var isSave = await widget.picData.downloadPhoto(widget.model);
      print(isSave);
    } else {
      _favIcon = Icons.favorite_border_outlined;
      _isFavorite = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(color: Colors.white);
    late CachedNetworkImage imageNetworkProfile;
    late ImageProvider imageProviderProfile;
    if (widget.isNetwork) {
      imageNetworkProfile = CachedNetworkImage(
        imageUrl: widget.model.user.profileImage.medium,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      var fileProfile = File(widget.model.user.profileImage.medium);
      imageProviderProfile = FileImage(fileProfile);
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
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              imageUrl: widget.model.urls.full,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: (widget.isNetwork)
                      ? imageNetworkProfile
                      : Image(
                          image: imageProviderProfile,
                        ),
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
            IconButton(
                onPressed: () {
                  setState(() {
                    _putFavorite();
                  });
                },
                icon: Icon(
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
