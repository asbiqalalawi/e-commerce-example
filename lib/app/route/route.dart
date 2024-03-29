import 'package:e_commerce_example/feature/cart/view/page/cart_page.dart';
import 'package:e_commerce_example/feature/home/view/page/home_page.dart';
import 'package:e_commerce_example/feature/login/view/page/login_page.dart';
import 'package:e_commerce_example/feature/product/view/page/product_detail_page.dart';
import 'package:e_commerce_example/feature/search/view/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      redirect: (context, state) async {
        final preferences = await SharedPreferences.getInstance();
        final token = preferences.getString('token');

        if (token != null) {
          return '/home';
        }
        return '/';
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'product/:id',
          name: 'product',
          builder: (BuildContext context, GoRouterState state) {
            return ProductDetailPage(id: int.parse(state.pathParameters['id']!));
          },
        ),
        GoRoute(
          path: 'search',
          name: 'search',
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
        GoRoute(
          path: 'cart',
          name: 'cart',
          builder: (BuildContext context, GoRouterState state) {
            return const CartPage();
          },
        ),
      ],
    ),
  ],
);
