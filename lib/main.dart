import 'package:e_commerce_example/feature/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_example/feature/cart/cubit/cart_cubit.dart';
import 'package:e_commerce_example/feature/cart/cubit/checkout_cubit.dart';
import 'package:e_commerce_example/feature/cart/service/cart_service.dart';
import 'package:e_commerce_example/feature/home/bloc/home_bloc.dart';
import 'package:e_commerce_example/feature/home/service/home_service.dart';
import 'package:e_commerce_example/feature/login/bloc/login_bloc.dart';
import 'package:e_commerce_example/feature/login/service/login_service.dart';
import 'package:e_commerce_example/feature/product/bloc/product_bloc.dart';
import 'package:e_commerce_example/feature/product/service/product_service.dart';
import 'package:e_commerce_example/feature/search/bloc/search_bloc.dart';
import 'package:e_commerce_example/app/route/route.dart';
import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(LoginService())),
        BlocProvider(create: (context) => HomeBloc(HomeService())),
        BlocProvider(create: (context) => SearchBloc(HomeService())),
        BlocProvider(create: (context) => ProductBloc(ProductService())),
        BlocProvider(create: (context) => CartBloc(CartService())),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => CheckoutCubit()),
      ],
      child: MaterialApp.router(
        title: 'Tokopakedi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ColorStyle.mainColor,
          ),
          textTheme: GoogleFonts.latoTextTheme(),
          scaffoldBackgroundColor: Colors.white,
        ),
        routerConfig: router,
      ),
    );
  }
}
