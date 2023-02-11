import 'package:flutter/material.dart';

class MyRowTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const MyRowTile({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
}
