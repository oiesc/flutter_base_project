import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../stores/home_store.dart';

mixin HomePageMixin<T extends StatefulWidget> on State<T> {
  HomeStore get homeStore => GetIt.I<HomeStore>();

  @override
  void initState() {
    super.initState();
    // Put any initialization logic here (after super.initState())
  }

  @override
  void dispose() {
    // Clean up resources if needed (before super.dispose())
    super.dispose();
  }
}
