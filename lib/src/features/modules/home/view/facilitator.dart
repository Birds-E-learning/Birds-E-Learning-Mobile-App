import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/facilitator_mixins.dart';
import 'package:flutter/material.dart';

class FacilitatorScreen extends StatefulWidget {
  const FacilitatorScreen({super.key});

  @override
  State<FacilitatorScreen> createState() => _FacilitatorScreenState();
}

class _FacilitatorScreenState extends State<FacilitatorScreen>
    with FacilitatorMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: leadingIcon(context),
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, vertical: size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: profilePicture("")),
            ],
          ),
        ),
      )),
    );
  }
}
