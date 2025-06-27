import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tool_nest/application/blocs/bottom_nav/nav_bloc.dart';
import 'package:tool_nest/config/theme/theme.dart';
import 'package:tool_nest/core/constants/text_strings.dart';
import 'application/blocs/auth/auth_bloc.dart';
import 'application/blocs/auth/auth_event.dart';
import 'application/blocs/home/home_page_bloc.dart';
import 'application/blocs/image_tools/image_compressor/image_compressor_bloc.dart';
import 'application/blocs/image_tools/image_format_converter/image_format_converter_bloc.dart';
import 'application/blocs/image_tools/image_resizer/image_resizer_bloc.dart';
import 'application/blocs/image_tools/image_to_pdf/image_to_pdf_bloc.dart';
import 'application/blocs/pdf_tools/compress_pdf/compress_pdf_bloc.dart';
import 'application/blocs/pdf_tools/merge_pdfs/merge_pdf_bloc.dart';
import 'application/blocs/pdf_tools/pdf_to_image/pdf_to_image_bloc.dart';
import 'application/blocs/pdf_tools/split_pdf/split_pdf_bloc.dart';
import 'config/router/app_router.dart';
import 'domain/repositories/auth_repositories/auth_repository.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())..add(AppStarted())),
        BlocProvider<HomePageBloc>(create: (_) => HomePageBloc()..add(LoadRecentFilesEvent()),),
        BlocProvider<NavBloc>(create: (_) => NavBloc(),),
        BlocProvider<ImageToPdfBloc>(create: (_) => ImageToPdfBloc(),),
        BlocProvider<ImageCompressorBloc>(create: (_) => ImageCompressorBloc(),),
        BlocProvider<ImageResizeBloc>(create: (_) => ImageResizeBloc(),),
        BlocProvider<ImageFormatConverterBloc>(create: (_) => ImageFormatConverterBloc(),),
        BlocProvider<PdfToImageBloc>(create: (_) => PdfToImageBloc(),),
        BlocProvider<MergePdfBloc>(create: (_) => MergePdfBloc(),),
        BlocProvider<SplitPdfBloc>(create: (_) => SplitPdfBloc(),),
        BlocProvider<CompressPdfBloc>(create: (_) => CompressPdfBloc(),),

      ],
      child: MaterialApp.router(
        title: TNTextStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: TNTheme.lightTheme,
        routerConfig: appRouter,

      ),
    );
  }
}
