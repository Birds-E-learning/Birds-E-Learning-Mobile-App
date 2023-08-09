import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_category_response.dart';
import 'package:birds_learning_network/src/features/core/blog/view/widget/category_container.dart';
import 'package:birds_learning_network/src/features/core/blog/view/widget/news_container.dart';
import 'package:birds_learning_network/src/features/core/blog/view/widget/news_section.dart';
import 'package:birds_learning_network/src/features/core/blog/view/widget/news_shimmer.dart';
import 'package:birds_learning_network/src/features/core/blog/view_model/blog_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.category});
  final CategoryData category;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with CourseTextWidgets{
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
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BlogProvider>(context, listen: false).refreshNewsData();
      Provider.of<BlogProvider>(context, listen: false).getCategoryNewsMethod(context,
          widget.category.id ?? "0");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title:  appBarText("News & Blogs"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: white,
        leading: leadingIcon(context),
      ),
      body: Consumer<BlogProvider>(
        builder: (_, news,__) => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: news.news.isEmpty
                ? news.newsStatus == Status.loading
                  ? const CustomNewsShimmer()
                  : Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NewsCategoryContainer(data: widget.category),
                        const SizedBox(height: 50),
                        const Center(
                          child: Text(
                            'No available news for this category',
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500,
                              color: black
                            )
                          )
                        )
                       ],
                    )
                : Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 210,
                        child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            itemCount: news.news.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return NewsContainer(
                                  data: news.news[index]
                              );
                            }
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDotIndicator(news.news.length, _currentPage),
                      const SizedBox(height: 15),
                      Expanded(
                          child: NewsSectionWidget(data: news.news[_currentPage]),
                      ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
