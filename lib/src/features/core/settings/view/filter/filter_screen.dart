import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: AuthenticationWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03, horizontal: size.width * 0.04),
            child: Column(),
          ),
        ),
      )),
    );
  }
}
