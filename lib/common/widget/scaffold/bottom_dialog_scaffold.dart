import 'package:flutter/material.dart';
import 'package:today_my_calendar/common/common.dart';
import 'transparent_scaffold.dart';

class BottomDialogScaffold extends StatelessWidget {
  final Widget body;
  const BottomDialogScaffold({required this.body, super.key});
  @override
  Widget build(BuildContext context) {
    return TransparentScaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height-70,
          padding: const EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
          decoration: BoxDecoration(
              color: context.backgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                body,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
