enum LanguageTranslations {
  english('en'),
  hindi('hi'),
  kannada('kn'),
  tamil('ta'),
  telugu('te');

  final String languageCode;
  const LanguageTranslations(this.languageCode);
}

enum AppFlavours {
  dev(label: 'dev'),
  staging(label: 'staging'),
  prod(label: 'prod');

  final String label;
  const AppFlavours({required this.label});
}
