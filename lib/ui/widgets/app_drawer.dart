import 'package:flutter/material.dart';
import 'package:news_c19/ui/utils/app_colors.dart';

class AppDrawer extends StatelessWidget {
  final bool showGoToHomeNavigation;

  const AppDrawer({super.key, required this.showGoToHomeNavigation});

  @override
  Widget build(BuildContext context) {
    //var theme = context.theme;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "News app",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              color: AppColors.black,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (showGoToHomeNavigation) ...[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.home,
                              size: 24,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Go to home",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider()
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
