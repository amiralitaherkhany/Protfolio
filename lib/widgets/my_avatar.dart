import 'package:flutter/material.dart';

class MyAvatar extends StatelessWidget {
  const MyAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(
            "assets/profile.png",
          ),
        ),
      ),
    );
  }
}
