import 'package:flutter/material.dart';
import 'package:news_c19/model/category_dm.dart';
import 'package:news_c19/ui/utils/app_routes.dart';
import 'package:news_c19/ui/utils/build_context_extensions.dart';
import 'package:news_c19/ui/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: AppDrawer(showGoToHomeNavigation: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Good Morning \nHere is Some News For You",
              style: theme.textTheme.titleMedium,
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: CategoryDM.categories.length,
                  itemBuilder: (context, index) => buildCategoryWidget(
                      context, CategoryDM.categories[index], index.isOdd)))
        ],
      ),
    );
  }

  Widget buildCategoryWidget(
      BuildContext context, CategoryDM category, bool isLeftSidedText) {
    var theme = context.theme;
    return InkWell(
      onTap: () {
        Navigator.push(context, AppRoutes.news(category));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        height: context.height * .25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
                image: AssetImage(
                  context.isDark ? category.imageLight : category.imageDark,
                ),
                fit: BoxFit.fill)),
        child: isLeftSidedText
            ? Row(
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        category.name,
                        style: theme.textTheme.titleLarge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: .5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: theme.secondaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("View All"),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer()
                ],
              )
            : Row(
                children: [
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        category.name,
                        style: theme.textTheme.titleLarge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: .5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text("View All"),
                            SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              radius: 24,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: theme.secondaryColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  ),
                ],
              ),
      ),
    );
  }
}
