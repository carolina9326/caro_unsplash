import 'dart:collection';

import 'package:flutter/cupertino.dart';

class UnsplashModel {
  final String id;
  final Urls urls;
  final User user;
  final int likes;

  const UnsplashModel(
      {required this.id,
      required this.urls,
      required this.user,
      required this.likes});

  factory UnsplashModel.fromJson(Map<String, dynamic> json) {
    final String _id = json['id'];
    final _urls = json['urls'] ?? '';
    final __urls = Urls.fromJson(_urls);
    final _user = json['user'] ?? '';
    final __user = User.fromJson(_user);
    final int _likes = json['likes'] ?? 0;
    return UnsplashModel(id: _id, urls: __urls, user: __user, likes: _likes);
  }

  Map toJson() => {
        'id': id,
        'urls': urls.toJson(),
        'user': user.toJson(),
        'likes': likes,
      };

  factory UnsplashModel.fakeData() {
    return const UnsplashModel(
        id: '123456',
        urls: Urls(
            full:
                'https://images.unsplash.com/photo-1553272725-086100aecf5e?crop=entropy&cs=srgb&fm=jpg&ixid=MnwzMTE3Mzh8MXwxfGFsbHwxfHx8fHx8Mnx8MTY0NzczOTM3NA&ixlib=rb-1.2.1&q=85',
            raw: '',
            small: '',
            regular: '',
            thumb: '',
            smallS3: '',
            large: '',
            medium: ''),
        user: User(
            id: '123',
            firstName: 'carolina',
            lastName: 'ruiz',
            userName: 'carito',
            profileImage: Urls(
                full: '',
                raw: '',
                small: '',
                regular: '',
                thumb: '',
                smallS3: '',
                large: '',
                medium:
                    'https://images.unsplash.com/profile-1633011648572-1129ea717d2bimage?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64')),
        likes: 55);
  }
}

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;
  final String large;
  final String medium;

  const Urls(
      {required this.raw,
      required this.full,
      required this.regular,
      required this.small,
      required this.smallS3,
      required this.thumb,
      required this.large,
      required this.medium});

  factory Urls.fromJson(Map<String, dynamic> json) {
    final _raw = json['raws'] ?? '';
    final _full = json['full'] ?? '';
    final _regular = json['regular'] ?? '';
    final _small = json['small'] ?? '';
    final _smallS3 = json['small_s3'] ?? '';
    final _thumb = json['thumb'] ?? '';
    final _large = json['large'] ?? '';
    final _medium = json['medium'] ?? '';
    return Urls(
        raw: _raw,
        full: _full,
        regular: _regular,
        small: _small,
        smallS3: _smallS3,
        thumb: _thumb,
        large: _large,
        medium: _medium);
  }

  Map toJson() => {
        'raw': raw,
        'full': full,
        'regular': regular,
        'small': small,
        'small_s3': smallS3,
        'thumb': thumb,
        'large': large,
        'medium': medium
      };
}

class User {
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final Urls profileImage;

  String get name => firstName + ' ' + lastName;

  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.profileImage});

  factory User.fromJson(Map<String, dynamic> json) {
    final _id = json['id'] ?? '';
    final _firstName = json['first_name'] ?? '';
    final _lastName = json['last_name'] ?? '';
    final _userName = json['username'] ?? '';
    final _profileImage = json['profile_image'] ?? '';
    final __profileImage = Urls.fromJson(_profileImage);
    return User(
        id: _id,
        firstName: _firstName,
        lastName: _lastName,
        userName: _userName,
        profileImage: __profileImage);
  }

  Map toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'user_name': userName,
        'profile_image': profileImage.toJson()
      };
}

class FavoritesNotifierModel extends ChangeNotifier {
  bool _isAdd = false;
  bool _isSearch = false;
  String _textToSearch = '';

  void addFavorite(bool value) {
    _isAdd = value;
    notifyListeners();
  }

  void addSearch(bool value) {
    _isSearch = value;
    notifyListeners();
  }

  void addTextToSearch(String value) {
    _textToSearch = value;
  }

  bool get isAdded => _isAdd;
  bool get isSearch => _isSearch;
  String get textToSearch => _textToSearch;
}
