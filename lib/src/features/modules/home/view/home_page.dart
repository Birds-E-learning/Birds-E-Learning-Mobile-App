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
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
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

  // @override
  // void initState() {
  //   Provider.of<HomeProvider>(context, listen: false).getHomeData(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    FilterProvider filter = Provider.of<FilterProvider>(context, listen: false);
    FilterProvider filterWatch = Provider.of<FilterProvider>(context);
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
                        : SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: filter.myList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (home.selectedCards.length <
                                    filter.myList.length) {
                                  home.selectedCards.add(false);
                                }
                                return InkWell(
                                  onTap: () {
                                    if (!home.selectedCards[index] &&
                                        _controller.text.trim().isEmpty) {
                                      home.setValue(index);
                                      _controller.text = filter.myList[index];
                                      home.onSearchTriggered(true);
                                      home.onSearchClicked(
                                          _controller.text.trim());
                                    } else if (home.selectedCards[index] &&
                                        _controller.text.trim() ==
                                            filter.myList[index]) {
                                      _controller.text = "";
                                      home.setValue(index);
                                      home.onSearchTriggered(false);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: topicText(
                                        filterWatch.myList[index],
                                        home.selectedCards[index]
                                            ? white
                                            : grey700,
                                        home.selectedCards[index]
                                            ? grey700
                                            : Colors.transparent),
                                  ),
                                );
                              },
                            ),
                          ),
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
                                SizedBox(
                                  height: 205,
                                  child: home.prefCourses.isEmpty
                                      ? ListView.builder(
                                          itemCount: 6,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const CustomHomeCardShimmer();
                                          })
                                      : ListView.builder(
                                          itemCount:
                                              home.prefCourses.length > 10
                                                  ? 10
                                                  : home.prefCourses.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (home.topIcons.length <
                                                home.prefCourses.length) {
                                              home.topIcons.add(false);
                                            }
                                            return InkWell(
                                              onTap: () =>
                                                  RoutingService.pushRouting(
                                                      context,
                                                      BuyCourseScreen(
                                                          course:
                                                              home.prefCourses[
                                                                  index])),
                                              child: CourseCard(
                                                iconData: home.topIcons[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_outline,
                                                onFavPressed: () {
                                                  home.setTopValue(index);
                                                },
                                                course: home.prefCourses[index],
                                              ),
                                            );
                                          }),
                                ),
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
                                SizedBox(
                                  height: 205,
                                  child: home.trendingCourses.isEmpty
                                      ? ListView.builder(
                                          itemCount: 6,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const CustomHomeCardShimmer();
                                          })
                                      : ListView.builder(
                                          itemCount:
                                              home.trendingCourses.length > 10
                                                  ? 10
                                                  : home.trendingCourses.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (home.trendingIcons.length <
                                                home.trendingCourses.length) {
                                              home.trendingIcons.add(false);
                                            }
                                            return InkWell(
                                              onTap: () => RoutingService
                                                  .pushFullScreenRouting(
                                                      context,
                                                      BuyCourseScreen(
                                                          course:
                                                              home.trendingCourses[
                                                                  index])),
                                              child: CourseCard(
                                                iconData: home
                                                        .trendingIcons[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_outline,
                                                onFavPressed: () {
                                                  home.setTrendingValue(index);
                                                },
                                                course:
                                                    home.trendingCourses[index],
                                              ),
                                            );
                                          }),
                                ),
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
                                SizedBox(
                                  height: 205,
                                  child: home.quickCourses.isEmpty
                                      ? ListView.builder(
                                          itemCount: 6,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const CustomHomeCardShimmer();
                                          })
                                      : ListView.builder(
                                          itemCount:
                                              home.quickCourses.length > 10
                                                  ? 10
                                                  : home.quickCourses.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (home.quickIcons.length <
                                                home.quickCourses.length) {
                                              home.quickIcons.add(false);
                                            }
                                            return InkWell(
                                              onTap: () => RoutingService
                                                  .pushFullScreenRouting(
                                                      context,
                                                      BuyCourseScreen(
                                                          course:
                                                              home.quickCourses[
                                                                  index])),
                                              child: CourseCard(
                                                iconData: home.quickIcons[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_outline,
                                                onFavPressed: () {
                                                  home.setQuickValue(index);
                                                },
                                                course:
                                                    home.quickCourses[index],
                                              ),
                                            );
                                          }),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.04),
                                  child: categoryHeaderText(
                                    HomeText.facilitators,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return const FacilitatorCard();
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
