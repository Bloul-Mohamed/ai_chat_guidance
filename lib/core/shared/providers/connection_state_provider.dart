import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Simple provider that returns true if online, false if offline

final internetProvider = StreamProvider.autoDispose<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((results) {
    return results != ConnectivityResult.none;
  });
});
