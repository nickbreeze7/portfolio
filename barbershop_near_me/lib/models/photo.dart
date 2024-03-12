class Photo {
  final String? photoReference;
  final int? height;
  final int? width;
  final List<String>? htmlAttributions;

  Photo(
      {required this.photoReference,
      required this.height,
      required this.width,
      required this.htmlAttributions});

  /*
  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
  */
  factory Photo.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Photo(
      photoReference: parsedJson['photo_reference'],
      height: parsedJson['height'],
      width: parsedJson['width'],
      htmlAttributions: parsedJson['html_attributions'] != null
          ? (parsedJson['html_attributions'] as List<dynamic>).cast<String>()
          : null,
    );
  }
}
