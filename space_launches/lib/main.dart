import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:space_launches/di/injection.dart' as di;
import 'package:space_launches/routes/router.gr.dart';
import 'package:upcoming_launches/upcoming_launches.dart';

void main() {
  di.configureDI(environment: Environment.prod);
  runApp(SpaceLaunchesApp());
}

class SpaceLaunchesApp extends StatelessWidget {
  const SpaceLaunchesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Color(0xFFD1B2F4),
          primaryColorBrightness: Brightness.dark,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(brightness: Brightness.dark),
        ),
        routerDelegate: di.getIt<SpaceLaunchesRouter>().delegate(),
        routeInformationParser:
            di.getIt<SpaceLaunchesRouter>().defaultRouteParser(),
        supportedLocales: [Locale('en'), Locale('fa')],
        // I want to pass other modules Localizations delegate to this list, so
        // MaterialApp knows where to lookup for localizations
        // UpcomingLaunchesLocalizations is generated is in this path:
        // features/upcoming_launches/.dart_tools/flutter_gen/gen_l10n
        // this files are generated based on the recommended approach of localizing text
        // https://docs.flutter.dev/development/accessibility-and-localization/internationalization
        // but problem is its not accessible from outside of the upcoming_launches
        // module. how can I solve it. I don't want to manually move those files
        // to the lib folder and make them accessible by exporting them in
        // upcoming_launches.dart becaue the new transaltion can be added or changed
        // and I may miss to move those files to the lib folder.
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          UpcomingLaunchesLocalizations.delegate,
        ],
      );
}
