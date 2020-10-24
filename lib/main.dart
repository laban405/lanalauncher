
import 'package:Lana/ui/pages/home_page/home_page.dart';
import 'package:Lana/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data_sources/app_repository.dart';
import 'data_sources/contact_repository.dart';
import 'generated/l10n.dart';
import 'models/app_model.dart';
import 'models/contact_model.dart';
import 'ui/theme.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppModel>(
              create: (_) => AppModel(dataRepository: AppRepository())),
          ChangeNotifierProvider<ContactModel>(
              create: (_) => ContactModel(dataRepository: ContactRepository()))
        ],
        child: MaterialApp(
          title: 'Lana',
          home: DefaultTabController(length: 2, child: HomePage()),
          onGenerateRoute: generateRoute,
          localizationsDelegates: [
            S.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: lightTheme,
          darkTheme: darkTheme,
        ));
  }
}
