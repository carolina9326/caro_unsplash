import 'package:caro_unsplash/models/unsplash_model.dart';

abstract class PicData {
  Future<List<UnsplashModel>> getPhotos({int page});
}
