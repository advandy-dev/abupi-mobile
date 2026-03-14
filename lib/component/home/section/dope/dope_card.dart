import 'package:flutter/material.dart';

class DopeCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  static const double _width = 80;
  static const double _height = 110;

  const DopeCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: _width,
      height: _height,
      child: Card(
        margin: EdgeInsets.zero,
        color: const Color.fromRGBO(127, 205, 255, 1),
        elevation: 2,
        child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  image,
                  height: 56,
                  width: 56,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}