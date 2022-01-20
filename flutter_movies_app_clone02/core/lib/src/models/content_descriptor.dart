import 'package:meta/meta.dart';


class ContentDescriptor {
  final String name;
  final String imageUrl;

  ContentDescriptor({
    required this.name,
    required this.imageUrl,
});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentDescriptor &&
        runtimeType == other.runtimeType &&
        name == other.name &&
        imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      name.hashCode ^
      imageUrl.hashCode;

  @override
  String toString() {
    return 'ContentDescriptor{name: $name, imageUrl: $imageUrl}';
  }
}