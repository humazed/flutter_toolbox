import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:flutter_toolbox_example/auth_provider.dart';

class AuthNavHomePage extends StatelessWidget with RouteNameProvider {
  const AuthNavHomePage({super.key});

  @override
  String get routeName => 'AuthNavHomePage';

  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthNavHomePage'),
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              MaterialButton(
                child: const Text('NeedsAuthPage'),
                onPressed: () => push(context, const NeedsAuthPage()),
              ),
              MaterialButton(
                child: const Text('NoAuthPage'),
                onPressed: () => push(context, const NoAuthPage()),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              MaterialButton(
                child: const Text('Login'),
                onPressed: () => authProvider.login(),
              ),
              MaterialButton(
                child: const Text('Logout'),
                onPressed: () => authProvider.logout(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NeedsAuthPage extends StatelessWidget with RouteNameProvider {
  const NeedsAuthPage({super.key});

  @override
  String get routeName => 'NeedsAuthPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeedsAuthPage'),
      ),
    );
  }
}

class NoAuthPage extends StatelessWidget with RouteNameProvider {
  const NoAuthPage({super.key});

  @override
  String get routeName => 'NoAuthPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoAuthPage'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget with RouteNameProvider {
  const LoginPage({super.key});

  @override
  String get routeName => 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
    );
  }
}
