import 'package:e_commerce_example/app/widget/rating.dart';
import 'package:e_commerce_example/feature/home/model/product_model.dart';
import 'package:e_commerce_example/app/shared/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchProductCard extends StatelessWidget {
  const SearchProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        'product',
        pathParameters: {
          'id': product.id.toString(),
        },
      ),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                product.image,
                height: 150,
                width: 150,
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          CurrencyFormat.usd(product.price),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Rating(rating: product.rating),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
