import 'package:e_commerce_example/app/widget/button.dart';
import 'package:e_commerce_example/app/widget/rating.dart';
import 'package:e_commerce_example/feature/product/bloc/product_bloc.dart';
import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:e_commerce_example/app/shared/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.id});

  final int id;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed('cart');
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            final product = state.product;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          product.image,
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          fit: BoxFit.scaleDown,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    CurrencyFormat.usd(product.price),
                                    style: const TextStyle(
                                      color: ColorStyle.mainColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.thumb_up_alt_outlined,
                                      color: ColorStyle.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              Rating(rating: product.rating),
                              const SizedBox(height: 20),
                              Text(
                                product.description,
                                style: const TextStyle(
                                  color: ColorStyle.subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Button(
                    text: 'Add to Cart',
                    onPressed: () {
                      context.goNamed('cart');
                    },
                  ),
                ),
              ],
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
