import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teambill/blocs/bloc.dart';
import 'package:teambill/configs/config.dart';
import 'package:teambill/utils/utils.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final LanguageBloc languageBloc;

  ApplicationBloc({
    required this.languageBloc,
  });

  @override
  ApplicationState get initialState => InitialApplicationState();

  @override
  Stream<ApplicationState> mapEventToState(event) async* {
    if (event is SetupApplication) {
      ///Pending loading to UI
      yield ApplicationWaiting();

      ///Setup SharedPreferences
      Application.preferences = await SharedPreferences.getInstance();

      ///Get old Language

      final oldLanguage = UtilPreferences.getString(Preferences.language);



      ///Setup Language
      if (oldLanguage != null) {
        languageBloc.add(
          ChangeLanguage(Locale(oldLanguage)),
        );
      }

      ///First or After upgrade version show intro preview app
      final hasReview = UtilPreferences.containsKey(
        '${Preferences.reviewIntro}.${Application.version}',
      );
      if (hasReview) {
        ///Become app
        yield ApplicationSetupCompleted();
      } else {
        ///Pending preview intro
        yield ApplicationIntroView();
      }
    }

    ///Event Completed IntroView
    if (event is OnCompletedIntro) {
      await UtilPreferences.setBool(
        '${Preferences.reviewIntro}.${Application.version}',
        true,
      );

      ///Become app
      yield ApplicationSetupCompleted();
    }
  }
}
