
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import 'bindings/bindings.dart';
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: JTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindigs(),
      ///show loader or circular progress indicator neon-white authentication repository is deciding to show relevant screen
      //home: const OnboardingScreen(),
      home: const Scaffold(backgroundColor: JColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white))),

    );
  }
}
