import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/settings/view/widgets/card_shimmer.dart';
import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_card.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/facilitator_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/view/categories/preference_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/categories/quick_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/categories/trending_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/custom_shimmer_card.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/preference_row.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/preferential_listview.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/quick_listview.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/facilitator_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/trending_listview.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with HomeWidgets, HomeText, FilterTextWidgets {
  final TextEditingController _controller = TextEditingController();
  GlobalKey topKey = GlobalKey();
  GlobalKey trendingKey = GlobalKey();
  GlobalKey quickKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Provider.of<HomeProvider>(context, listen: false).refreshData(context);
    FilterProvider filter = Provider.of<FilterProvider>(context, listen: false);
    // CartProvider cartw = context.watch<CartProvider>();
    CartProvider cart = context.read<CartProvider>();
    return Consumer<HomeProvider>(
      builder: (_, home, __) => BackgroundWidget(
        appBar: SliverAppBar(
          title: home.onSearch ? null : greetingText(home.firstName),
          pinned: home.onSearch ? false : true,
          floating: home.onSearch ? false : true,
          elevation: 0,
          backgroundColor: backgroundBlurColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: home.onSearch ? 0 : size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: CustomFieldNoLabel(
                    hintText: HomeText.search,
                    isHome: true,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, size: 20)),
                    controller: _controller,
                    onChanged: (text) {
                      if (_controller.text.trim().isEmpty) {
                        home.onSearchTriggered(false);
                        home.selectedCards = [];
                        FocusScope.of(context).unfocus();
                      } else {
                        home.onSearchTriggered(true);
                        home.onSearchClicked(_controller.text.trim());
                      }
                    },
                    suffixIcon: home.onSearch
                        ? IconButton(
                            onPressed: () {
                              _controller.clear();
                              setState(() {});
                              home.selectedCards = [];
                              home.onSearchTriggered(false);
                              FocusScope.of(context).unfocus();
                            },
                            icon: const Icon(Icons.clear))
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                home.onSearch
                    ? Container(child: null) //const FilterCardShimmer()
                    : filter.myList.isEmpty
                        ? SizedBox(
                            height: 40,
                            child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, __) {
                                  return const FilterCardShimmer();
                                }))
                        : PreferenceRowContainer(controller: _controller),
                const SizedBox(height: 20),
                context.watch<HomeProvider>().searchResult.isNotEmpty &&
                        home.onSearch
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            child: searchHeaderText(_controller.text),
                          ),
                          const SizedBox(height: 15),
                          ListView.builder(
                              itemCount: home.searchResult.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04),
                              itemBuilder: (BuildContext context, int index) {
                                return CourseRowCards(
                                  course: home.searchResult[index],
                                  onTap: () =>
                                      RoutingService.pushFullScreenRouting(
                                          context,
                                          BuyCourseScreen(
                                              course:
                                                  home.searchResult[index])),
                                );
                              }),
                        ],
                      )
                    : context.watch<HomeProvider>().searchResult.isEmpty &&
                            home.onSearch
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04),
                                child: searchHeaderText(_controller.text),
                              ),
                              SizedBox(height: size.height * 0.1),
                              Center(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(ImagePath.noCourse),
                                    const SizedBox(height: 10),
                                    noCourseText()
                                  ],
                                ),
                              )
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                categoryRowText(
                                  "Top Picks for you",
                                  () {
                                    RoutingService.pushFullScreenRouting(
                                        context,
                                        const PreferenceCoursesScreen());
                                  },
                                  EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                ),
                                const SizedBox(height: 15),
                                const PreferentialListView(),
                                const SizedBox(height: 15),
                                categoryRowText(
                                  "Trending Courses",
                                  () {
                                    RoutingService.pushFullScreenRouting(
                                        context, const TrendingCoursesScreen());
                                  },
                                  EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                ),
                                const SizedBox(height: 15),
                                const TrendingListView(),
                                const SizedBox(height: 20),
                                categoryRowText(
                                  "Quick Courses",
                                  () {
                                    RoutingService.pushFullScreenRouting(
                                        context, const QuickCoursesScreen());
                                  },
                                  EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                ),
                                const SizedBox(height: 15),
                                const QuickListView(),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                  child: categoryHeaderText(
                                    HomeText.facilitators,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                home.trendingCourses.isEmpty
                                    ? ListView.builder(
                                        itemCount: 4,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return const FacilitatorShimmer();
                                        })
                                    : ListView.builder(
                                        itemCount:
                                            home.trendingCourses.length > 4
                                                ? 4
                                                : home.trendingCourses.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return FacilitatorCard(
                                            facilitator: home
                                                .trendingCourses[index]
                                                .facilitator!,
                                          );
                                        }),
                              ],
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
