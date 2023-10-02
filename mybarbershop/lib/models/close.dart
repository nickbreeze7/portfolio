class Close {
  final int? day;
  final String? time;

  Close({required this.day, required this.time});

  factory Close.fromJson(Map<String, dynamic> parsedJson) {
    return Close(
      day:parsedJson['day'],
      time:parsedJson['time'],
    );
  }
}