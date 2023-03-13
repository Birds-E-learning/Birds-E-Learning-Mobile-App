import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/profile/custom_widgets/custom_card_container.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/cards/add_card.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/cards/view_cards.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/card_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSettingPage extends StatelessWidget with ProfileWidgets {
  const CardSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<CardProvider>(context, listen: false).getAllDebitCards(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: appBarText(ProfileTexts.cardSetting),
        centerTitle: true,
        elevation: 0,
        leading: leadingIcon(context),
      ),
      body: Consumer<CardProvider>(
        builder: (_, card, __) => SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardContainer(
                  image: ImagePath.creditCard,
                  text: ProfileTexts.debitText,
                  onTap: () async {
                    RoutingService.pushFullScreenRouting(
                        context, const ViewDebitCardPage());
                  }),
              const SizedBox(height: 15),
              CardContainer(
                  image: ImagePath.addCard,
                  text: ProfileTexts.newCardText,
                  onTap: () {
                    RoutingService.pushRouting(context, const AddCardPage());
                  }),
              SizedBox(height: size.height * 0.2),
              const Center(child: Image(image: AssetImage(ImagePath.cardss)))
            ],
          ),
        )),
      ),
    );
  }
}
