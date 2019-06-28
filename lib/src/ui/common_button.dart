import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double textSize;
  final String path;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
            if (path != null) Navigator.of(context).pushNamed(path);
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: textSize),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CommonButton({this.text, this.textSize = 18, this.path, this.onTap});
}
