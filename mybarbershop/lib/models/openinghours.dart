
import 'period.dart';

class OpeningHours {
   final  bool? openNow;
   final List<String>? weekdayText;
   late final List<Period>? periods;

  OpeningHours({
      required this.openNow,
      required  this.weekdayText,
      required this.periods
  });



  /* OpeningHours.fromJson(Map<dynamic, dynamic> parsedJson)
    : openNow = parsedJson['open_now'];
*/

 factory OpeningHours.fromJson(Map<dynamic, dynamic> parsedJson) {
     return OpeningHours(
      openNow : parsedJson['open_now'],
       // weekdayText 밑에 (....List<dynamic>) 가로 하니까 에러가 다 사라짐... 20230726
       weekdayText : parsedJson['weekday_text'] != null
                   ? (parsedJson['weekday_text'] as List<dynamic>).cast<String>():null,
       periods: (parsedJson['periods'] != null)
           ? parsedJson['periods']
           .map<Period>((parsedJson) => Period.fromJson(parsedJson))
           .toList()
           : List.empty(),
     );
   }
}


