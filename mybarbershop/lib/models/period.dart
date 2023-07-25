import 'close.dart';
import 'open.dart';

class Period {
   late final Close? close;
   late final Open? open;

   Period({required this.close, required this.open});

   factory Period.fromJson(Map<dynamic, dynamic> parsedJson){
     return Period(
       close:parsedJson['close']!=null? Close.fromJson(parsedJson['close']):null,
       open:parsedJson['open']!=null? Open.fromJson(parsedJson['open']):null,
     );
   }
}