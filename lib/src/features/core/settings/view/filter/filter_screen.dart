import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/get_started_screen.dart';
import 'package:birds_learning_network/src/features/core/settings/view/widgets/card_shimmer.dart';
import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view/home.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/filter_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with FilterTextWidgets, FilterTexts {
  TextEditingController textField = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textField.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<FilterProvider>(context, listen: false).getPreferenceList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Consumer<FilterProvider>(
        builder: (_, filter, __) => AuthenticationWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.03, horizontal: size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: filterHeader(),
                  ),
                  filterText(),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomFieldNoLabel(
                      controller: textField,
                      hintText: FilterTexts.hintText,
                      maxLines: 7,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                  filter.getStatus == Status.loading
                      ? GridView.builder(
                          shrinkWrap: true,
                          itemCount: 6,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 21 / 9),
                          itemBuilder: (_, __) {
                            return const FilterCardShimmer();
                          })
                      : filter.myList.isNotEmpty
                      ?   GridView.builder(
                          // primary: false,
                          shrinkWrap: true,
                          itemCount: filter.myList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 21 / 9),
                          itemBuilder: (BuildContext context, int index) {
                            if (filter.selectedCards.length <
                                filter.myList.length) {
                              filter.selectedCards.add(false);
                            }
                            return InkWell(
                              onTap: () {
                                filter.setValue(index);
                                if (filter.selectedCards[index] &&
                                    !textField.text
                                        .contains(filter.myList[index])) {
                                  textField.text += "${filter.myList[index]}, ";
                                  filter.addPref(filter.myList[index]);
                                } else {
                                  textField.text = textField.text.replaceFirst(
                                      "${filter.myList[index]}, ", "");
                                  filter.removePref(filter.myList[index]);
                                }
                              },
                              child: topicText(
                                  filter.myList[index],
                                  filter.selectedCards[index] ? white : grey700,
                                  filter.selectedCards[index]
                                      ? grey700
                                      : white),
                            );
                          }): const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                    child: Center(
                      child: Text(
                        "There is no available area of interest, proceed to setup your profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                          onPressed: () async {
                            if (filter.buttonClicked) {
                              filter.onButtonClick();
                              return;
                            }
                            if (filter.userPrefList.isEmpty) {
                              RoutingService.pushAndRemoveAllRoute(
                                  context, const GetStartedPage());
                            } else {
                              filter.onButtonClick();
                              await filter.postPreferenceList(context);
                            }
                          },
                          child: filter.buttonClicked
                              ? loadingIdicator()
                              : getStartedButtonText()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  setupProfile(() {
                    Provider.of<HomeProvider>(context, listen: false)
                        .onItemClick = 3;
                    RoutingService.pushAndRemoveAllRoute(
                        context, const BirdsHome());
                  }),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
