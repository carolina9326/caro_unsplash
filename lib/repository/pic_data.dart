import 'package:caro_unsplash/models/unsplash_model.dart';

abstract class PicData {
  Future<List<UnsplashModel>> getPhotos({int page});
  Future<bool> downloadPhoto(UnsplashModel model);
  FavoritesNotifierModel get favorites;
  Future<List<UnsplashModel>> searchPhotos(String query);
}
