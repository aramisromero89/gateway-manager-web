import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gateway_manager_client/components/login_component.dart';
import 'package:gateway_manager_client/logic/auth_provider.dart';
import 'package:gateway_manager_client/logic/user_provider.dart';

class CustomScaffold extends ConsumerWidget {
  final Widget child;
  final String text;
  const CustomScaffold({Key? key, required this.child, this.text = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: token == null
          ? null
          : AppBar(
              leading: Container(),
              title: Text(text),
              actions: [
                user.value == null
                    ? const CircularProgressIndicator()
                    : PopupMenuButton(
                        child: CircleAvatar(
                          child: Text(user.value!.username[0].toUpperCase()),
                        ),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  enabled: false,
                                  child: Text(user.value!.username)),
                              PopupMenuItem(
                                  onTap: () => ref.read(authProvider).logout(),
                                  child: Text("Logout")),
                            ]),
                const SizedBox(width: 20),
              ],
            ),
      body: token == null
          ? const LoginComponent()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
    );
  }
}
