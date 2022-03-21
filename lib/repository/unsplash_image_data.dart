import 'dart:convert';

import 'package:caro_unsplash/models/constans.dart';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnsplasImageData implements PicData {
  late Dio _dio;
  late Map<String, dynamic> _headers;
  UnsplasImageData() {
    var options = BaseOptions(
      baseUrl: Constans.unsplashApiServer,
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
    _headers = {};
    _headers.putIfAbsent('Authorization', () => Constans.unsplashAccesKey);
    _headers.putIfAbsent('Accept-Version', () => Constans.unsplashApiVersion);
    _dio = Dio(options);
  }

  @override
  Future<List<UnsplashModel>> getPhotos({int page = 0}) async {
    List<UnsplashModel> data = [];
    // page--;

    // for (var i = 0; i < 32; i++) {
    //   data.add(UnsplashModel.fakeData(idP: i));
    // }

    // int pageT = (page == 0) ? (page * 10) : (page * 10) + page;
    // var da = data.skip(pageT).take(10).toList();

    // return Future.sync(() => da);

    var response = await _dio.request(
      '/photos',
      queryParameters: {'page': page},
      options: Options(method: 'GET', headers: _headers),
    );

    for (var e in response.data) {
      final x = UnsplashModel.fromJson(e);
      data.add(x);
    }

    return data;
  }

  Future<bool> downloadPhoto(UnsplashModel model) async {
    final prefs = await SharedPreferences.getInstance();
    var dir = await getApplicationDocumentsDirectory();

    var response = await _dio.download(
        model.urls.full, '${dir.path}/p/${model.id}',
        onReceiveProgress: (rec, total) {});

    String jsonModel = jsonEncode(model);

    var result1 = await prefs.setString(model.id, jsonModel);

    var result2 = await prefs.setBool('f${model.id}', true);

    return true;
  }
}
