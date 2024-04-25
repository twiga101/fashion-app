import 'package:flutter/material.dart';
import 'package:fashon_app/screens/search/component/search_body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(child: Scaffold(
      body: SearchBody(),
    ),);
  }
}