import 'package:caro_unsplash/models/constans.dart';
import 'package:dio/dio.dart';

class UnsplashApi {
  late Dio _dio;
  UnsplashApi() {
    var options = BaseOptions(
      baseUrl: Constans.unsplashApiServer,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
  }

  void getPhotos() {}
}
