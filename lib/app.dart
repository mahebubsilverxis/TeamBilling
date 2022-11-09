import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teambill/blocs/bloc.dart';
import 'package:teambill/configs/config.dart';
import 'package:teambill/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash/splash_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // final Routes route = Routes();

  late ApplicationBloc _applicationBloc;
  LanguageBloc _languageBloc = LanguageBloc();

  @override
  void initState() {
    ///Bloc business logic
    _languageBloc = LanguageBloc();
    _applicationBloc = ApplicationBloc(
      languageBloc: _languageBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _applicationBloc.close();
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (context) => _applicationBloc,
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => _languageBloc,
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, lang) {
          return MaterialApp(
              theme: ThemeData(
                fontFamily: 'Helvetica',
              ),
              debugShowCheckedModeBanner: false,
              locale: AppLanguage.defaultLanguage,
              localizationsDelegates: [
                Translate.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLanguage.supportLanguage,
              home: SplashScreen());
        },
      ),
    );
  }
}
