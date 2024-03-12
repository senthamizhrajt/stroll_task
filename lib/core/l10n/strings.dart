import 'localization_service.dart';

enum Strings {
  close,
  unknownRoute,
  username,
  question1,
  option1,
  option2,
  option3,
  option4,
  questionInfoText,
  userAnswer,
  screenTitle,
  strollQuestion,
  delete,
  submit,
  unMatch
}

extension TKeysExtension on Strings {
  String get _string => name;

  String translate(context) {
    return AppLocalizations.of(context)!.text(_string) ?? '';
  }
}
