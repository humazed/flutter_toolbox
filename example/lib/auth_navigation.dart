import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:flutter_toolbox_example/auth_provider.dart';

class AuthNavHomePage extends StatelessWidget {
  const AuthNavHomePage({super.key});

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

class NeedsAuthPage extends StatelessWidget {
  const NeedsAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeedsAuthPage'),
      ),
    );
  }
}

class NoAuthPage extends StatelessWidget {
  const NoAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoAuthPage'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
    );
  }
}
