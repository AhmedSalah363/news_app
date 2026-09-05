import 'package:news_c19/ui/utils/app_assets.dart';

class CategoryDM {
  final String name;
  final String imageLight;
  final String imageDark;

  const CategoryDM(
      {required this.name, required this.imageDark, required this.imageLight});

  static const List<CategoryDM> categories = [
    CategoryDM(
        name: "General",
        imageDark: AppAssets.generalDark,
        imageLight: AppAssets.generalLight),
    CategoryDM(
        name: "Business",
        imageDark: AppAssets.businessDark,
        imageLight: AppAssets.businessLight),
    CategoryDM(
        name: "Sports",
        imageDark: AppAssets.sportDark,
        imageLight: AppAssets.sportLight),
    CategoryDM(
        name: "Technology",
        imageDark: AppAssets.technologyDark,
        imageLight: AppAssets.technologyLight),
    CategoryDM(
        name: "Entertainment",
        imageDark: AppAssets.generalDark,
        imageLight: AppAssets.generalLight),
    CategoryDM(
        name: "Health",
        imageDark: AppAssets.healthDark,
        imageLight: AppAssets.healthLight),
    CategoryDM(
        name: "Science",
        imageDark: AppAssets.scienceDark,
        imageLight: AppAssets.scienceLight),
  ];
}
