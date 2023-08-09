import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/blog/view/widget/blog_shimmer.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/blog/view/screen/news_screen.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/blog/view/widget/category_container.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/blog/view_model/blog_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_news_header.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnregisteredBlogNewsSection extends StatefulWidget {
  const UnregisteredBlogNewsSection({super.key});

  @override
  State<UnregisteredBlogNewsSection> createState() => _UnregisteredBlogNewsSectionState();
}

class _UnregisteredBlogNewsSectionState extends State<UnregisteredBlogNewsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Widget _buildDotIndicator(int pageCount, int currentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return Container(
            width: currentPage == index ? 16 : 8,
            height: currentPage == index ? 8 : 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: currentPage == index ? success600 : success200,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UnregisteredBlogProvider>(
      builder: (_, news, __) => Column(
        children: [
          const TitleHeader(
            title: "News & Blogs",
            image: ImagePath.stroke,
          ),
          const SizedBox(height: 16),
          news.newsCategories.isEmpty
            ? news.categoryStatus == Status.loading
              ? const CustomCategoryShimmer()
              : const Center(
            child: Text(
              "No available News & Blog",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: success900
              ),
            ),
          )
            : SizedBox(
              height: 210,
              child: Center(
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                  itemCount: news.newsCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () =>
                          RoutingService.pushRouting(context, UnregisteredNewsScreen(category: news.newsCategories[index])),
                      child: UnregisteredNewsCategoryContainer(
                          data: news.newsCategories[index]
                      ),
                    );
                  }
            ),
              ),
          ),
          const SizedBox(height: 10),
          _buildDotIndicator(news.newsCategories.length, _currentPage),
        ],
      ),
    );
  }
}
