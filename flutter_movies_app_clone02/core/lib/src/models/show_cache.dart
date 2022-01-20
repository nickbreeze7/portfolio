import 'package:core/src/redux/app/app_state.dart';
import 'package:intl/intl.dart';

import 'theater.dart';


class DateTheaterPair {
  static final ddMMyyyy = new DateFormat('dd.MM.yyyy');

  DateTheaterPair(this.dateTime, this.theater);

  DateTheaterPair.fromState(AppState state)
    :  dateTime = state.showState.selectedDate,
       theater = state.theaterState.currentTheater;

  final DateTime dateTime;
  final Theater theater;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateTheaterPair &&
     runtimeType == other.runtimeType &&
     dateTime == other.dateTime &&
     theater == other.theater;

  @override
  int get hashCode => dateTime.hashCode ^ theater.hashCode;
}