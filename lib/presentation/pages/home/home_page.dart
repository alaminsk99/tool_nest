import 'package:flutter/material.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import  'package:lucide_icons_flutter/lucide_icons.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TNTextStrings.appName,style: Theme.of(context).textTheme.headlineMedium,),
        actions: [IconButton(onPressed: (){},icon:  Icon(LucideIcons.settings),),]
      ),
    );
  }
}
