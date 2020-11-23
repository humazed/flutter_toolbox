import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:flutter_toolbox_example/auth_provider.dart';

class AuthNavHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('AuthNavHomePage'),
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              MaterialButton(
                child: Text('NeedsAuthPage'),
                onPressed: () => push(context, NeedsAuthPage()),
              ),
              MaterialButton(
                child: Text('NoAuthPage'),
                onPressed: () => push(context, NoAuthPage()),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              MaterialButton(
                child: Text('Login'),
                onPressed: () => authProvider.login(),
              ),
              MaterialButton(
                child: Text('Logout'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NeedsAuthPage'),
      ),
    );
  }
}

class NoAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoAuthPage'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
    );
  }
}
