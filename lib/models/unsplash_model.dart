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
        likes: 150);
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
}
