import 'package:meta/meta.dart';

class Actor {

  final String name;
  final String avatarUrl;

  Actor({
    required this.name,
    this.avatarUrl,
});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Actor &&
        runtimeType == other.runtimeType &&
        name == other.name &&
        avatarUrl == other.avatarUrl;

  @override
  int get hashCode =>
        name.hashCode &
      avatarUrl.hashCode;
}