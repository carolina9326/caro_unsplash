import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalImageData implements PicData {
  @override
  final FavoritesNotifierModel favorites;

  LocalImageData({required this.favorites});

  @override
  Future<List<UnsplashModel>> getPhotos({int page = 0}) async {
    var data = await _loadData();

    page--;

    int pageT = (page == 0) ? (page * 2) : (page * 2) + 1;

    final dataList = data.skip(pageT).take(10).toList();
    return dataList;
  }

  @override
  Future<bool> downloadPhoto(UnsplashModel model) async {
    final prefs = await SharedPreferences.getInstance();
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
        if (filename == model.id) {
          f.deleteSync();
          prefs.remove(model.id);
          prefs.remove('f$filename}');
          return true;
        }
      }
    }

    return true;
  }

  @override
  Future<List<UnsplashModel>> searchPhotos(String query) async {
    var data = await _loadData();

    final dataList = data
        .where((x) => x.user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return dataList;
  }

  Future<List<UnsplashModel>> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<UnsplashModel> data = [];

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
        Map<String, dynamic> unsplashModelMap = jsonDecode(dataJson!);
        var __urls = unsplashModelMap['urls'];
        __urls['full'] = f.path;
        // var __user = unsplashModelMap['user'];
        // var __userProfle = __user['profile_image'];
        // __userProfle['medium'] = f.path;
        var unsplashModel = UnsplashModel.fromJson(unsplashModelMap);
        data.add(unsplashModel);
      }
    }

    return data;
  }
}
