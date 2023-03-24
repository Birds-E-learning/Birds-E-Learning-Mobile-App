import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/settings/view/widgets/card_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/edit_preference.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/filter_texts.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class EditPreferenceScreen extends StatefulWidget {
  const EditPreferenceScreen({super.key});

  @override
  State<EditPreferenceScreen> createState() => _EditPreferenceScreenState();
}

class _EditPreferenceScreenState extends State<EditPreferenceScreen>
    with FilterTextWidgets, FilterTexts, ProfileWidgets {
  TextEditingController textField = TextEditingController();

  @override
  void dispose() {
    textField.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showPref();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: appBarText(ProfileTexts.preferences),
        centerTitle: true,
        leading: leadingIcon(context),
        elevation: 0,
        backgroundColor: white,
      ),
      body: SafeArea(
          child: Consumer<PreferenceProvider>(
        builder: (_, filter, __) => AuthenticationWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  filter.myList.isEmpty
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
                      : GridView.builder(
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
                                    filter.myList.length &&
                                filter.prefList
                                    .contains(filter.myList[index])) {
                              filter.selectedCards.add(true);
                            } else if (filter.selectedCards.length <
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
                          }),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                          onPressed: () async {
                            if (filter.doneClicked) {
                              filter.onDoneClick();
                              return;
                            }
                            if (filter.userPrefList.isEmpty) {
                              showSnack(
                                  context, "02", "No Preference selected");
                            } else {
                              filter.onDoneClick();
                              await filter.postPreferenceList(context);
                            }
                          },
                          child: filter.doneClicked
                              ? loadingIdicator()
                              : doneButtonText()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future showPref() async {
    await Provider.of<PreferenceProvider>(context, listen: false)
        .getUserPreferenceList(context);
    if (!mounted) return;
    await Provider.of<PreferenceProvider>(context, listen: false)
        .getPreferenceList(context);
    if (!mounted) return;
    List<String> prefList =
        Provider.of<PreferenceProvider>(context, listen: false).prefList;
    if (prefList.isNotEmpty) {
      textField.text = "${prefList.toSet().join(", ")}, ";
    }
  }
}
