part of 'res_cubit.dart';

class ResState extends Equatable {
  final Locale locale;
  final bool switchTheme;

  const ResState({
    required this.locale,
    required this.switchTheme,
  });

  @override
  List<Object> get props => [locale, switchTheme];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'locale': locale.languageCode});
    result.addAll({'switchTheme': switchTheme});

    return result;
  }

  factory ResState.fromMap(Map<String, dynamic> map) {
    return ResState(
      locale: Locale(map['locale']),
      switchTheme: map['switchTheme'] ?? false,
    );
  }
}

final class ResInit extends ResState {
  const ResInit({required super.locale, required super.switchTheme});
}

final class LanguageChanging extends ResState {
  const LanguageChanging({required super.locale, required super.switchTheme});
}
