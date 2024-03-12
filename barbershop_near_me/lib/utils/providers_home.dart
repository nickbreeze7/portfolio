import 'package:flutter_riverpod/flutter_riverpod.dart';

//final kilometerProvider = StateProvider<double>((ref) => 1.0); // Default to 1 km
// Assuming you fetch this value from user preferences or a similar source
double initialKilometerValue = 1.0 /* fetch from preferences or default to 1.0 */;

final kilometerProvider = StateProvider<double>((ref) => initialKilometerValue);
