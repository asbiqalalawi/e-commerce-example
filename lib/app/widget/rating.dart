import 'package:e_commerce_example/feature/home/model/product_model.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final RatingModel rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 12,
          color: Colors.yellow.shade700,
        ),
        const SizedBox(width: 4),
        Text(
          '${rating.rate}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${rating.count} Reviews',
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
