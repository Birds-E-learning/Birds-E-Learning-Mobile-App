import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/get_started_screen.dart';
import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/filter_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/filter_mixins/filter_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with FilterTextWidgets, FilterTexts {
  TextEditingController textField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Consumer<FilterProvider>(
        builder: (_, filter, __) => AuthenticationWidget(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                      maxLines: 8,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      // primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: filter.myList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (filter.selectedCards.length <
                            filter.myList.length) {
                          filter.selectedCards.add(false);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              // print(filter.myList[index]);
                              filter.setValue(index);
                              if (filter.selectedCards[index] &&
                                  !textField.text
                                      .contains(filter.myList[index])) {
                                textField.text += "${filter.myList[index]}, ";
                              } else {
                                textField.text = textField.text.replaceFirst(
                                    "${filter.myList[index]}, ", "");
                              }
                            },
                            child: topicText(
                                filter.myList[index],
                                filter.selectedCards[index] ? white : grey700,
                                filter.selectedCards[index] ? grey700 : white),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                          onPressed: () {
                            RoutingService.pushReplacementRouting(
                                context, const GetStartedPage());
                          },
                          child: getStartedButtonText()),
                    ),
                  ),
                  const SizedBox(height: 10),
                  setupProfile(() {
                    print("Profile");
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
