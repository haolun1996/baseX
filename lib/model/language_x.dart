part of model;

class XLanguage extends XData {
  final String title;
  final Locale locale;

  XLanguage(this.title, this.locale);

  @override
  JSON toJson() => {
        'title': title,
        'locale': locale,
      };
}
