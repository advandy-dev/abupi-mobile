import 'package:abupi/models/news.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback onTap;
  final bool compact;

  const NewsCard({
    super.key,
    required this.news,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: compact ? null : 280,
      margin: compact ? null : const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: compact ? LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      news.imageURL,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            color: colorScheme.primaryContainer,
                            child: Center(
                              child: Icon(
                                Icons.event_rounded,
                                size: 32,
                                color:
                                colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: colorScheme
                              .surfaceContainerHighest,
                          child: const Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      news.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      news.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        ) : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image
            AspectRatio(
              aspectRatio: compact ? 16 / 10 : 16 / 9,
              child: Image.network(
                news.imageURL,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colorScheme.primaryContainer,
                  child: Center(
                    child: Icon(
                      Icons.event_rounded,
                      size: 40,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
            // Content - fixed height so card has bounded size; enough room for 2 + 3 lines
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Text(
                news.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                news.description,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
