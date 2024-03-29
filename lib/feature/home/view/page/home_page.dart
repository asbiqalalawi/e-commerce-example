import 'package:e_commerce_example/feature/home/bloc/home_bloc.dart';
import 'package:e_commerce_example/feature/home/view/widget/product_card.dart';
import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetHomeEvent());
  }

  void _logout(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: ColorStyle.mainColor,
      title: const Text('Logut Confirmation'),
      content: const Text('Are you sure want to logout?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            context.pop();
          },
        ),
        TextButton(
          child: const Text('Logout'),
          onPressed: () async {
            final preferences = await SharedPreferences.getInstance();
            preferences.clear().then((value) => context.goNamed('login'));
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: ColorStyle.mainColor,
        leading: IconButton(
          onPressed: () {
            _logout(context);
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
        title: const Text(
          'Tokopakedi',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed('search');
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
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
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hi, Asbiq',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'What are you looking for today?',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                      itemCount: state.products.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: state.products[index],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is HomeError) {
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
