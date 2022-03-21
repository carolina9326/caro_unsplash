import 'package:caro_unsplash/models/constans.dart';
import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';
import 'package:dio/dio.dart';

class UnsplasImageData implements PicData {
  late Dio _dio;
  late Map<String, dynamic> _headers;
  UnsplasImageData() {
    var options = BaseOptions(
      baseUrl: Constans.unsplashApiServer,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _headers = {};
    _headers.putIfAbsent('Authorization', () => Constans.unsplashAccesKey);
    _headers.putIfAbsent('Accept-Version', () => Constans.unsplashApiVersion);
    _dio = Dio(options);
  }

  @override
  Future<List<UnsplashModel>> getPhotos({int page = 1}) async {
    List<UnsplashModel> data = [];

    var response = await _dio.request(
      '/photos',
      queryParameters: {'page': page},
      options: Options(method: 'GET', headers: _headers),
    );

    for (var e in response.data) {
      final x = UnsplashModel.fromJson(e);
      data.add(x);
    }

    return Future.sync(() => data);
  }
}
