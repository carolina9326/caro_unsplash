import 'package:caro_unsplash/models/unsplash_model.dart';

abstract class PicData {
  List<UnsplashModel> getPhotos(int page);
}
