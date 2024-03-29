import 'dart:ui';

import 'package:e_commerce_example/app/shared/colors.dart';
import 'package:flutter/material.dart';

class Loadable extends StatelessWidget {
  const Loadable({super.key, this.appBar, required this.body, this.loading = false, this.bottomSheet});

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomSheet;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Stack(
          children: [
            body,
            if (loading)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.grey[200]!.withOpacity(0.4),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: ColorStyle.mainColor,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      bottomSheet: bottomSheet,
    );
  }
}
