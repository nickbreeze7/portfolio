import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a state provider to track SDK initialization status
final sdkInitializedProvider = StateProvider<bool>((ref) => false);

