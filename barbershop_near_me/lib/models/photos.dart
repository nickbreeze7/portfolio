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
  Photos.fromJson(Map<String, dynamic> parsedJson)
      : photoReference = parsedJson['photo_reference'],
        height = parsedJson['height'],
        width = parsedJson['width'],
         htmlAttributions = parsedJson['html_attributions'].cast<String>();
       /* htmlAttributions = parsedJson['html_attributions'] != null
            ? (parsedJson['html_attributions'] as List<dynamic>).cast<String>()
            : [];*/

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data =  <String, dynamic>{};
      data['height'] = height;
      data['html_attributions'] = htmlAttributions;
      data['photo_reference'] = photoReference;
      data['width'] = width;
      return data;
    }
}

/*  Photos.fromJson(Map<dynamic, dynamic> parsedJson) {
    height = parsedJson['height'];
    htmlAttributions = parsedJson['html_attributions'].cast<String>();
    photoReference = parsedJson['photo_reference'];
    width = parsedJson['width'];
  }*/

