// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'controllers/binding/binding.dart';
// import 'utils/constants/view_consants.dart';
// import 'utils/lanugage/languages.dart';
// import 'utils/route/route_generator.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: Colors.white,
//         primaryColor: Colors.blue,
//         useMaterial3: true,
//         // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
//       ),
//       translations: Languages(),
//       locale: const Locale('en', 'US'),
//       fallbackLocale: const Locale('en', 'US'),
//       debugShowCheckedModeBanner: false,
//       initialRoute: kSplashViewRoute,
//       initialBinding: ControllerBinder(),
//       getPages: RouteGenerator.getPages(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this for SystemChrome
import 'package:get/get.dart';

import 'controllers/binding/binding.dart';
import 'utils/constants/view_consants.dart';
import 'utils/lanugage/languages.dart';
import 'utils/route/route_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the system navigation bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.transparent, 
      systemNavigationBarIconBrightness: Brightness.dark, 
      // systemNavigationBarDividerColor: Colors.transparent, 
    ));

    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
        useMaterial3: true,
        // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute: kSplashViewRoute,
      initialBinding: ControllerBinder(),
      getPages: RouteGenerator.getPages(),
    );
  }
}