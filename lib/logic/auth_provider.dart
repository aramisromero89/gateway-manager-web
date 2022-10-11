import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gateway_manager_client/logic/shared_preferences_provider.dart';

import '../api/api_provider.dart';
import '../api/params/auth/login.dart';
import '../util/toast_helper.dart';

const tokenKey = "token";

final tokenProvider = StateProvider<String?>((ref) {
  return ref.read(sharedPreferencesProvider).getString(tokenKey);
});

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider {
  final Ref _ref;
  AuthProvider(this._ref);

  Future<void> loginOrRegister(String user, String password,
      {bool register = false}) async {
    final future = register
        ? _ref
            .read(apiProvider)
            .authRegister(Login(username: user, password: password))
        : _ref
            .read(apiProvider)
            .authLogin(Login(username: user, password: password));
    final res = await _ref.read(requestHelperProvider).request(future);

    _ref.read(tokenProvider.notifier).state = res.data?.token;

    if (res.data == null) {
      showToast("Invalid credentials");
      _ref.read(sharedPreferencesProvider).remove(tokenKey);
    } else {
      _ref.read(sharedPreferencesProvider).setString(tokenKey, res.data!.token);
    }
  }

  logout() {
    _ref.read(tokenProvider.notifier).state = null;
    _ref.read(sharedPreferencesProvider).remove(tokenKey);
  }
}
