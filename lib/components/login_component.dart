import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gateway_manager_client/api/api_provider.dart';
import 'package:gateway_manager_client/api/params/auth/login.dart';
import 'package:gateway_manager_client/logic/auth_provider.dart';

import '../logic/shared_preferences_provider.dart';
import '../util/custom_validators.dart';

class LoginComponent extends ConsumerStatefulWidget {
  const LoginComponent({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginComponentState();
}

class _LoginComponentState extends ConsumerState<LoginComponent> {
  final _fkey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pwdConfirmController = TextEditingController();
  bool _isRegister = false;
  bool _sending = false;
  bool _visiblePwd = false;
  bool _visibleConfirmPwd = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: _isRegister ? 380 : 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _fkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isRegister ? "Register" : "Login",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      label: Text("Username"),
                    ),
                    validator: emptyValidator,
                  ),
                  TextFormField(
                    controller: _pwdController,
                    obscureText: !_visiblePwd,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _visiblePwd = !_visiblePwd;
                          });
                        },
                        icon: Icon(_visiblePwd
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    validator: emptyValidator,
                  ),
                  if (_isRegister)
                    TextFormField(
                      controller: _pwdConfirmController,
                      obscureText: !_visibleConfirmPwd,
                      decoration: InputDecoration(
                        label: const Text("Confirm password"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _visibleConfirmPwd = !_visibleConfirmPwd;
                            });
                          },
                          icon: Icon(_visibleConfirmPwd
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      validator: (text) {
                        if (text != _pwdController.text) {
                          return "Password must be equal";
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _sending
                        ? null
                        : () async {
                            if (!_fkey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              _sending = true;
                            });
                            await ref.read(authProvider).loginOrRegister(
                                _userController.text, _pwdController.text,
                                register: _isRegister);

                            setState(() {
                              _sending = false;
                            });
                          },
                    child: Text(
                      _isRegister ? "Register" : "Login",
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_isRegister)
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isRegister = false;
                          });
                        },
                        child: const Text("Back to login"))
                  else
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isRegister = true;
                          });
                        },
                        child: const Text("Register")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
