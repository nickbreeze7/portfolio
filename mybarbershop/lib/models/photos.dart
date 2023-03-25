class Photos {
   final String photoReference;
   final int height;
   final int width;
   final List<String> htmlAttributions;

  Photos(
      {required this.photoReference,
      required this.height,
      required this.width,
      required this.htmlAttributions});

  /*
  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
  */
  Photos.fromJson(Map<dynamic, dynamic> parsedJson)
      : photoReference = parsedJson['photo_reference'],
        height = parsedJson['height'],
        width = parsedJson['width'],
         htmlAttributions = parsedJson['html_attributions'].cast<String>();
       /* htmlAttributions = parsedJson['html_attributions'] != null
            ? (parsedJson['html_attributions'] as List<dynamic>).cast<String>()
            : [];*/

/*  Photos.fromJson(Map<dynamic, dynamic> parsedJson) {
    height = parsedJson['height'];
    htmlAttributions = parsedJson['html_attributions'].cast<String>();
    photoReference = parsedJson['photo_reference'];
    width = parsedJson['width'];
  }*/
}
