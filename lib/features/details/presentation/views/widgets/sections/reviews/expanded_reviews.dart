import 'package:flutter/material.dart';
import 'package:movies_mage/constants.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/sections/reviews/reviews_model.dart';

class ExpandableReview extends StatelessWidget {
  final ReviewsModel review;
  final ValueNotifier<bool> _expanded = ValueNotifier(false);

  ExpandableReview({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author
          Text(
            review.author,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),

          // Content (collapsible)
          ValueListenableBuilder<bool>(
            valueListenable: _expanded,
            builder: (context, expanded, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.content,
                    maxLines: expanded ? null : 3, // 3 lines collapsed
                    overflow: expanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () => _expanded.value = !expanded,
                    child: Text(
                      expanded ? "View Less" : "View More",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
