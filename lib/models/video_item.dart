class VideoMetaData{
  final String name;
  final String url;
  final String image;
  final String description;
  final String language;
  final String duration;
  VideoMetaData(
    {
      required this.description,
      required this.image,
      required this.name,
      required this.url,
      required this.duration,
      required this.language,
    }
  );
}