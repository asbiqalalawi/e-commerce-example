import 'package:e_commerce_example/app/widget/button.dart';
import 'package:e_commerce_example/feature/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_example/feature/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_example/feature/cart/cubit/checkout_cubit.dart';
import 'package:e_commerce_example/feature/cart/model/cart_model.dart';
import 'package:e_commerce_example/feature/cart/view/widget/cart_card.dart';
import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:e_commerce_example/app/shared/currency_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCartEvent());
  }

  @override
  void didChangeDependencies() {
    context.read<CheckoutCubit>().resetPrice();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartSuccess) {
            context.read<CartCubit>().setProductCart(state.cart);
            return BlocBuilder<CartCubit, CartModel>(
              builder: (context, cart) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          return CartCard(
                            productCart: cart.products[index],
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                        itemCount: cart.products.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total ${cart.products.length} items',
                                style: const TextStyle(
                                  color: ColorStyle.subtitleColor,
                                ),
                              ),
                              BlocBuilder<CheckoutCubit, double>(
                                builder: (context, state) {
                                  return Text(
                                    CurrencyFormat.usd(state),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Button(
                            onPressed: () {},
                            text: 'Checkout',
                            icon: Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is CartError) {
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
