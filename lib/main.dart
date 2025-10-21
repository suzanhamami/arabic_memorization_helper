// import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/presentation/comparison/bloc/comparison_bloc.dart';
import 'package:internship_project/presentation/pages/home_page.dart';
import 'package:internship_project/presentation/pages/memorization_page.dart';
import 'package:internship_project/presentation/transcription/bloc/transcription_bloc.dart';
import 'package:internship_project/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
  FlutterError.presentError(details);
  print('❌ Flutter Error: ${details.exceptionAsString()}');
};
PlatformDispatcher.instance.onError = (error, stack) {
  print('❌ Platform Error: $error');
  return true;
};
  // await dotenv.load(fileName: '.env');

  await setUpLocator();
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(), // Wrap your app
    // ),
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TranscriptionBloc>()),
        BlocProvider(create: (context) => getIt<ComparisonBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            home: HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
