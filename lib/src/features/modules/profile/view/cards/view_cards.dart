import 'package:birds_learning_network/src/features/modules/profile/custom_widgets/custom_card_container.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/get_card_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/cards/custom_card.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/card_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_indicator.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/hash_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDebitCardPage extends StatefulWidget {
  const ViewDebitCardPage({super.key});

  @override
  State<ViewDebitCardPage> createState() => _ViewDebitCardPageState();
}

class _ViewDebitCardPageState extends State<ViewDebitCardPage>
    with ProfileWidgets {
  @override
  void initState() {
    Provider.of<CardProvider>(context, listen: false).resetCurrentPosition = 0;
    super.initState();
  }

  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: appBarText(ProfileTexts.debitText),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        leading: leadingIcon(context),
      ),
      body: Consumer<CardProvider>(
        builder: (_, card, __) => SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                card.cardList.isEmpty
                    ? CustomCard(
                        card: CardResponseData(
                            cardNo: "1234567890123456",
                            cardType: "Verve",
                            expiryDate: "Nov/2024"))
                    : CarouselSlider.builder(
                        itemCount: card.cardList.length,
                        carouselController: controller,
                        itemBuilder: (BuildContext context, int index,
                            int pageviewIndex) {
                          return CustomCard(card: card.cardList[index]);
                        },
                        options: CarouselOptions(
                            aspectRatio: 13 / 9,
                            viewportFraction: 0.92,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            enlargeFactor: 0.2,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) =>
                                card.getCurrentPosition(index)),
                      ),
                const SizedBox(height: 20),
                CustomIndicator(
                  count: card.cardList.length,
                  position: card.currentPosition,
                  activeColor: success600,
                  color: success200,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: CardRowContainer(
                      image: ImagePath.creditCard,
                      text: "Delete Card",
                      onTap: () async {
                        if (card.cardList.isNotEmpty) {
                          await deleteDialog(context, card);
                        } else {
                          showSnack(context, "02", "Add a new card");
                        }
                      }),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  deleteDialog(BuildContext context, CardProvider card) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Delete Card!',
                style: ProfileStyles.logoutHeaderStyle,
              ),
              content: Text(
                "You are about to delete this card (${hashCardNo(card.cardList[card.currentPosition].cardNo!)})",
                style: ProfileStyles.logoutTextStyle,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'CANCEL',
                    style: ProfileStyles.logoutButtonStyle,
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      if (card.confirmClicked) {
                        card.onConfirmClick();
                        return;
                      }
                      card.onConfirmClick();
                      await card.deleteCard(
                          context, card.cardList[card.currentPosition].cardNo!);
                    },
                    child: context.watch<CardProvider>().confirmClicked
                        ? loadingIdicator()
                        : const Text(
                            'CONFIRM',
                            style: ProfileStyles.logoutButtonStyle,
                          )),
              ],
            );
          });
        });
  }
}
