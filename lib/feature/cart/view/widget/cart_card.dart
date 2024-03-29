import 'package:e_commerce_example/feature/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_example/feature/cart/cubit/checkout_cubit.dart';
import 'package:e_commerce_example/feature/cart/model/cart_model.dart';
import 'package:e_commerce_example/feature/product/service/product_service.dart';
import 'package:e_commerce_example/app/shared/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.productCart,
    required this.index,
  });

  final ProductCartModel productCart;
  final int index;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool first = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductService().getProduct(widget.productCart.productId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final product = snapshot.data!;

          return Card(
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
                    width: 120,
                    height: 120,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
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
                        BlocBuilder<CartCubit, CartModel>(
                          builder: (context, state) {
                            if (first) {
                              context
                                  .read<CheckoutCubit>()
                                  .addPrice(state.products[widget.index].quantity * product.price);
                            }
                            first = false;

                            return Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: state.products[widget.index].quantity <= 1
                                      ? null
                                      : () {
                                          context.read<CartCubit>().updateQuantity(
                                                state.products[widget.index].productId,
                                                state.products[widget.index].quantity - 1,
                                              );
                                          context.read<CheckoutCubit>().minPrice(product.price);
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: state.products[widget.index].quantity <= 1 ? Colors.grey : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    '${state.products[widget.index].quantity}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () {
                                    context.read<CartCubit>().updateQuantity(
                                          state.products[widget.index].productId,
                                          state.products[widget.index].quantity + 1,
                                        );
                                    context.read<CheckoutCubit>().addPrice(product.price);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black12,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    context.read<CartCubit>().removeProduct(state.products[widget.index].productId);
                                    context
                                        .read<CheckoutCubit>()
                                        .minPrice(state.products[widget.index].quantity * product.price);
                                  },
                                  child: const Icon(Icons.delete_outline),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
