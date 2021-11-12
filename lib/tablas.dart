import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  const AppTabs({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        child: Text(
          this.text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: this.color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                offset: const Offset(0, 0),
              )
            ]));
  }
}
