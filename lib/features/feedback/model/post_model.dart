class PostModel {
  final String userName;
  final String profileImgUrl;
  final String role;
  final List<String> imgUrl;
  final String text;
  final int like;
  final int comment;

  PostModel({
    required this.userName,
    required this.profileImgUrl,
    required this.role,
    required this.imgUrl,
    required this.text,
    required this.like,
    required this.comment,
  });
}
