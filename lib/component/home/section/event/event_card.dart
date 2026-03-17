import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:abupi/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final bool compact;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: compact ? null : 280,
      margin: compact ? null : const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: compact
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                event.imageUrl != null
                                  ? Image.network(
                                      event.imageUrl!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error,
                                          stackTrace) =>
                                          Container(
                                            color: Colors.grey.shade500,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              // Match the ClipRRect radius here!
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.event_rounded,
                                                size: 32,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                      loadingBuilder: (context, child,
                                          loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          color: Colors.grey,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                        );
                                      },
                                  )
                                : Container(
                                    color: Colors.grey.shade500,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade500,
                                      // Match the ClipRRect radius here!
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.event_rounded,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                if (DateTime.now()
                                    .isAfter(DateTime.parse(event.endDate)))
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFe2642a),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Text(
                                        l10n?.done ?? 'Selesai',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (event.location != null)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 10,
                                      color: Color(0xFF632f9c),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        event.location!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: const Color(0xFF632f9c),
                                              fontSize: 10,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              if (event.location != null)
                                const SizedBox(height: 2),
                              Text(
                                event.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                event.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                  fontSize: 12,
                                  color: Colors.grey.shade500
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 10,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      event.formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontSize: 10,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  // Event image
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: event.imageUrl != null ? Image.network(
                      event.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade500,
                        child: const Center(
                          child: Icon(
                            Icons.event_rounded,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    )
                        : Container(
                      color: Colors.grey.shade500,
                      child: const Center(
                        child: Icon(
                          Icons.event_rounded,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  if (DateTime.now().isAfter(DateTime.parse(event.endDate))) ...[
                    Positioned(
                      top: 1,
                      right: 1,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFe2642a),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          l10n?.done ?? 'Selesai',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
            // Content - fixed height so card has bounded size in vertical ListView
            SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // location row
                    Row(
                      children: [
                        if (event.location != null) ...[
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: Color(0xFF632f9c),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              event.location!,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF632f9c),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // View details
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.formattedDate,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
