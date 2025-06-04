import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import  'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tool_nest/presentation/pages/home/widgets/appbar/home_appbar.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:HomeAppbar(),
    );
  }
}
