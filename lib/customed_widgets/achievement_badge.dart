import 'package:bookkeeping/app_tools.dart';
import 'package:flutter/material.dart';

class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.imagePath,
    required this.describe,
  });

  final String imagePath;
  final String describe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          AppTools.showPopup(
            context,
            widget: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imagePath),
                  const SizedBox(height: 40),
                  Text(
                    describe,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
        child: Image.asset(imagePath, width: 120, height: 120),
      ),
    );
  }
}
