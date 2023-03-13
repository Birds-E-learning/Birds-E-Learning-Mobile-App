import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      this.title,
      this.centerTitle = false,
      this.leading,
      this.trailing});
  final Widget? title;
  final bool centerTitle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leading,
      trailing: trailing,
      title: centerTitle
          ? Center(
              child: title,
            )
          : title,

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     SizedBox(
      //       width: size.width * 0.15,
      //       child: leading ?? Container(child: null),
      //     ),
      //     SizedBox(width: leading == null ? 30 : 20),
      //     // SizedBox(
      //     //   width: centerTitle ? size.width * 0.1 : 0,
      //     // ),
      //     Expanded(
      //         child: title != null
      //             ? Container(
      //                 child: centerTitle
      //                     ? Center(
      //                         child: title,
      //                       )
      //                     : title,
      //               )
      //             : Container(child: null)),
      //     const Spacer(),
      //     SizedBox(
      //         width: size.width * 0.15,
      //         child: trailing ?? Container(child: null))
      //   ],
      // ),
    );
  }
}
