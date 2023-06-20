class ActivityItem {
  final String title;
  final String image;
  final String description;
  Uri moreInfo;

  ActivityItem(
      {required this.title,
      required this.image,
      required this.description,
      required String moreInfo})
      : moreInfo = Uri.parse(moreInfo);
}
