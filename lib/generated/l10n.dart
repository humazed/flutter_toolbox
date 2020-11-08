// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Required Field`
  String get required_field {
    return Intl.message(
      'Required Field',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Please check your connection`
  String get please_check_your_connection {
    return Intl.message(
      'Please check your connection',
      name: 'please_check_your_connection',
      desc: '',
      args: [],
    );
  }

  /// `Server error`
  String get server_error {
    return Intl.message(
      'Server error',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `The email address or password is wrong`
  String get the_email_address_or_password_is_wrong {
    return Intl.message(
      'The email address or password is wrong',
      name: 'the_email_address_or_password_is_wrong',
      desc: '',
      args: [],
    );
  }

  /// `This file is not an image`
  String get this_file_is_not_an_image {
    return Intl.message(
      'This file is not an image',
      name: 'this_file_is_not_an_image',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get select_time {
    return Intl.message(
      'Select time',
      name: 'select_time',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get select_date {
    return Intl.message(
      'Select date',
      name: 'select_date',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get please_check_your_internet_connection {
    return Intl.message(
      'Please check your internet connection',
      name: 'please_check_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch google maps`
  String get could_not_launch_google_maps {
    return Intl.message(
      'Could not launch google maps',
      name: 'could_not_launch_google_maps',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open this url`
  String get couldnt_open_this_url {
    return Intl.message(
      'Couldn\'t open this url',
      name: 'couldnt_open_this_url',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open the mail app`
  String get couldnt_open_the_mail_app {
    return Intl.message(
      'Couldn\'t open the mail app',
      name: 'couldnt_open_the_mail_app',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open the phone app`
  String get couldnt_open_the_phone_app {
    return Intl.message(
      'Couldn\'t open the phone app',
      name: 'couldnt_open_the_phone_app',
      desc: '',
      args: [],
    );
  }

  /// `Add photo`
  String get add_photo {
    return Intl.message(
      'Add photo',
      name: 'add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}