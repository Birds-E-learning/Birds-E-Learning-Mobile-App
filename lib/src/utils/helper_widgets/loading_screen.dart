import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575), // background color
      child: const Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(success1000), // progress bar color
        ),
      ),
    );
  }
}

Container loadingScreen(bool isLoading) {
  return Container(
    color: const Color(0xff757575), // background color
    child: isLoading
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  success1000), // progress bar color
            ),
          )
        : null,
  );
}
