import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class Responsive extends StatefulWidget {
  final myMobileScreen;
  final myWebScreen;
  const Responsive(
      {super.key, required this.myMobileScreen, required this.myWebScreen});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  // To get data from DB using provider
  getDataFromDB() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints) {
        if (BoxConstraints.maxWidth > 600) {
          return widget.myWebScreen;
        } else {
          return widget.myMobileScreen;
        }
      },
    );
  }
}
