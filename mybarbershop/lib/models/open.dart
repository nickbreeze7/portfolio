class Open {
  final int? day;
  final String? time;

  Open({required this.day, required this.time});

  factory Open.fromJson(Map<String, dynamic> parsedJson) {
  return Open(
        day:parsedJson['day'],
        time:parsedJson['time'],
  );
  }

}