import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalImageData implements PicData {
  @override
  Future<List<UnsplashModel>> getPhotos({int page = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    List<UnsplashModel> data = [];

    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());

    var dir = await getApplicationDocumentsDirectory();

    var dirp = Directory('${dir.path}/p/');

    var isD = dirp.existsSync();
    if (!isD) {
      dirp.createSync();
    }
    var listDir = dirp.listSync();

    for (var f in listDir) {
      if (f is File) {
        String filename = basename(f.path);
        var dataJson = prefs.getString(filename);
        Map<String, dynamic> user = jsonDecode(dataJson!);
        print(f.path);
      }
    }

    return Future.sync(() => data);
  }

  @override
  Future<bool> downloadPhoto(UnsplashModel model) {
    // TODO: implement downloadPhoto
    throw UnimplementedError();
  }
}
