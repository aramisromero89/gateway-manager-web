import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((_) =>
    throw Exception(
        "sharedPreferencesProvider state value must be overrided on ProviderScope with the result of SharedPreferences.getInstance()"));
