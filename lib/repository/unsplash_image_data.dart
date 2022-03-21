import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';

class UnsplasImageData implements PicData {
  @override
  List<UnsplashModel> getPhotos(int page) {
    List<UnsplashModel> data = [];

    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());

    return data;
  }
}
