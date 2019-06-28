import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  final String avatarUrl;
  final String userName;
  final String email;
  final GestureTapCallback onAvatarTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    print("children.length = ${children.length}");

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              userName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: InkWell(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage("https://carbla.absher.it$avatarUrl"),
              ),
              onTap: onAvatarTap,
            ),
            margin: EdgeInsets.zero,
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: ListView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.only(top: 8),
                shrinkWrap: true,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  CommonDrawer({
    this.avatarUrl,
    this.userName,
    this.email,
    this.onAvatarTap,
    this.children,
  });
}
