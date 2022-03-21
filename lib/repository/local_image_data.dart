import 'package:caro_unsplash/models/unsplash_model.dart';
import 'package:caro_unsplash/repository/pic_data.dart';

class LocalImageData implements PicData {
  @override
  Future<List<UnsplashModel>> getPhotos({int page = 0}) {
    List<UnsplashModel> data = [];

    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());
    data.add(UnsplashModel.fakeData());

    return Future.sync(() => data);
  }
}
