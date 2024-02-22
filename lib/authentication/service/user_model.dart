class UserModel {
  final String userName;
  final String email;
  UserModel({
    required this.userName,
    required this.email,
  });
}

class Description {
  final String title;
  final String units;
  final String basePeriod;

  Description({
    required this.title,
    required this.units,
    required this.basePeriod,
  });
}
