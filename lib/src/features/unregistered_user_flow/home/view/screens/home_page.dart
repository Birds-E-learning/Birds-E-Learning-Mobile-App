import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/settings/view/widgets/card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/facilitator_shimmer.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/blog/view/widget/news_card_full.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/blog/view_model/blog_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/screens/categories/preference_courses.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/screens/categories/quick_courses.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view/screens/categories/trending_courses.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/custom_widgets/course_row_card.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/custom_widgets/facilitator_card.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/widgets/course/preference_row.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/widgets/course/preferential_listview.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/widgets/course/quick_listview.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/widgets/course/trending_listview.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/pop_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UnregisteredUserHomePage extends StatefulWidget {
  const UnregisteredUserHomePage({super.key});

  @override
  State<UnregisteredUserHomePage> createState() => _UnregisteredUserHomePageState();
}

class _UnregisteredUserHomePageState extends State<UnregisteredUserHomePage>
    with HomeWidgets, HomeText, FilterTextWidgets {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
   SchedulerBinding.instance.addPostFrameCallback((_) {
     Provider.of<UnregisteredHomeProvider>(context, listen: false).getPreferenceList(context);
     Provider.of<UnregisteredBlogProvider>(context, listen: false).getNewsCategoryMethod(context);
     Provider.of<UnregisteredCourseProvider>(context, listen: false).refreshData(context, reload: false);
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final courseRead = context.read<UnregisteredCourseProvider>();
    final courseWatch = context.watch<UnregisteredCourseProvider>();
    courseRead.refreshData(context);
    return Consumer<UnregisteredHomeProvider>(
      builder: (_, home, __) => Scaffold(
        appBar: AppBar(
          title: courseWatch.onSearch ? null : greetingText(courseWatch.firstName),
          elevation: 0,
        ),
        body: WillPopScope(
           onWillPop: ()async{
              if(courseRead.searchResult.isNotEmpty && _controller.text.trim().isNotEmpty){
                _controller.clear();
                setState(() {});
                courseRead.selectedCards = [];
                courseRead.onSearchTriggered(false);
                FocusScope.of(context).unfocus();
                return false;
              }else{
                bool shouldPop = await getPopScopeDialog(context);
                return shouldPop;
              }},
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: courseWatch.onSearch ? 0 : size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        child: CustomFieldNoLabel(
                          hintText: HomeText.search,
                          isHome: true,
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search, size: 20)),
                          controller: _controller,
                          onChanged: (text) {
                            if (_controller.text.trim().isEmpty) {
                              courseRead.onSearchTriggered(false);
                              courseRead.selectedCards = [];
                              FocusScope.of(context).unfocus();
                            } else {
                              courseRead.onSearchTriggered(true);
                              courseRead.onSearchClicked(_controller.text.trim());
                            }
                          },
                          suffixIcon: courseWatch.onSearch
                              ? IconButton(
                              onPressed: () {
                                _controller.clear();
                                setState(() {});
                                courseRead.selectedCards = [];
                                courseRead.onSearchTriggered(false);
                                FocusScope.of(context).unfocus();
                              },
                              icon: const Icon(Icons.clear))
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      courseWatch.onSearch
                          ? Container(child: null) //const FilterCardShimmer()
                          : home.prefList.isEmpty && home.loadingStatus == Status.loading
                          ? SizedBox(
                          height: 40,
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, __) {
                                return const FilterCardShimmer();
                              }))
                          : home.prefList.isEmpty && home.loadingStatus != Status.loading
                          ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03),
                        child: const Center(
                          child: Text("No preference list.",
                              style: CartStyles.richStyle1),
                        ),
                      )
                          : PreferenceRowContainer(controller: _controller),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: courseWatch.searchResult.isNotEmpty &&
                          courseWatch.onSearch
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: searchHeaderText(_controller.text),
                          ),
                          const SizedBox(height: 15),
                          ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              separatorBuilder: (_, __) => const SizedBox(
                                height: 30,
                                child: Divider(
                                    thickness: 0.2, color: success1000),
                              ),
                              itemCount:  courseWatch.searchResult.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return UnregisteredCourseRowCards(
                                  course: courseWatch.searchResult[index],
                                );
                              }),
                        ],
                      )
                          : courseWatch.searchResult.isEmpty && courseWatch.onSearch
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: categoryRowText(
                                "Top Picks for you",
                                    () {
                                  RoutingService.pushFullScreenRouting(
                                      context,
                                      const UnregisteredPreferenceCoursesScreen());
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            RefreshIndicator(
                                onRefresh: () => courseWatch.refreshData(context,
                                    reload: false),
                                child: const PreferentialListView()),
                            const SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: categoryRowText(
                                "Trending Courses",
                                    () {
                                  RoutingService.pushFullScreenRouting(
                                      context,
                                      const UnregisteredTrendingCoursesScreen());
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            RefreshIndicator(
                                onRefresh: () => courseWatch.refreshData(context,
                                    reload: false),
                                child: const UnregisteredTrendingListView()),
                            const SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: categoryRowText(
                                "Quick Courses",
                                    () {
                                  RoutingService.pushFullScreenRouting(
                                      context, const UnregisteredQuickCoursesScreen());
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            RefreshIndicator(
                                onRefresh: () => courseWatch.refreshData(context,
                                    reload: false),
                                child: const UnregisteredQuickListView()),
                            const SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: categoryHeaderText(
                                HomeText.facilitators,
                              ),
                            ),
                            const SizedBox(height: 16),
                            courseWatch.trendingCourses.isEmpty
                                ? courseWatch.trendingStatus == Status.loading
                                ? ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                                itemCount: 4,
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return const FacilitatorShimmer();
                                })
                                : const Center(
                              child: Text(
                                "No available top facilitator.",
                                style: CartStyles.richStyle1,
                              ),
                            )
                                : ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03),
                                separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                                itemCount:
                                courseWatch.trendingCourses.length > 4
                                    ? 4
                                    : courseWatch.trendingCourses.length,
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return FacilitatorCard(
                                    facilitator: courseWatch
                                        .trendingCourses[index]
                                        .facilitator!,
                                  );
                                }),
                            const SizedBox(height: 40),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.03),
                              child: const  UnregisteredBlogNewsSection(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
