import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_c19/model/articles_response.dart';
import 'package:news_c19/ui/utils/build_context_extensions.dart';
import 'package:news_c19/ui/widgets/article_bottom_sheet.dart';
import 'package:timeago/timeago.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleDM articleDM;

  const ArticleWidget({super.key, required this.articleDM});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.tryParse(articleDM.publishedAt ?? "");
    var theme = context.theme;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ArticleBottomSheet(articleDM: articleDM),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.secondaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: articleDM.urlToImage ?? "",
                height: context.height * .25,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              articleDM.title ?? "",
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (articleDM.author != null)
                  Expanded(
                    child: Text(
                      "By: ${articleDM.author}",
                      style: theme.textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (date != null)
                  Text(
                    format(date),
                    style: theme.textTheme.displayMedium,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
