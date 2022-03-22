import 'dart:convert';

import 'package:caro_unsplash/models/constans.dart';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnsplasImageData implements PicData {
  @override
  final FavoritesNotifierModel favorites;
  late Dio _dio;
  late Map<String, dynamic> _headers;
  UnsplasImageData({required this.favorites}) {
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

    var response = await _dio.request(
      '/photos',
      queryParameters: {'page': page},
      options: Options(method: 'GET', headers: _headers),
    );

    //return data;
    if (response.statusCode != 200) {
      return data;
    }

    for (var e in response.data) {
      final x = UnsplashModel.fromJson(e);
      data.add(x);
    }

    return data;
  }

  Future<List<UnsplashModel>> searchPhotos(String query) async {
    List<UnsplashModel> data = [];

    var response = await _dio.request(
      '/search/photos',
      queryParameters: {'page': 1, 'query': query},
      options: Options(method: 'GET', headers: _headers),
    );

    //return data;
    if (response.statusCode != 200) {
      return data;
    }

    var results = response.data['results'];

    for (var e in results) {
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
