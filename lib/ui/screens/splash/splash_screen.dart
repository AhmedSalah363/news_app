import 'package:flutter/material.dart';
import 'package:news_c19/ui/utils/app_assets.dart';
import 'package:news_c19/ui/utils/app_routes.dart';
import 'package:news_c19/ui/utils/app_theme.dart';
import 'package:news_c19/ui/utils/build_context_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.push(context, AppRoutes.home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
        body: Image.asset(
            alignment: AlignmentGeometry.center,
            context.isDark ? AppAssets.splashDark : AppAssets.splashLight));
  }
}
