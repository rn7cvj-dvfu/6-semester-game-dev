///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsStringsEn strings = TranslationsStringsEn._(_root);
}

// Path: strings
class TranslationsStringsEn {
	TranslationsStringsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get settings => 'Settings';
	String get statistic => 'Statistics';
	String get back => 'Back';
	String get useDarkTheme => 'Темная тема';
	String get useSeedColor => 'Основной цвет';
	late final TranslationsStringsLevelsEn levels = TranslationsStringsLevelsEn._(_root);
	late final TranslationsStringsCommonEn common = TranslationsStringsCommonEn._(_root);
}

// Path: strings.levels
class TranslationsStringsLevelsEn {
	TranslationsStringsLevelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsStringsLevelsK1En k1 = TranslationsStringsLevelsK1En._(_root);
}

// Path: strings.common
class TranslationsStringsCommonEn {
	TranslationsStringsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get next => 'Далее';
	String get finish => 'Завершить';
}

// Path: strings.levels.k1
class TranslationsStringsLevelsK1En {
	TranslationsStringsLevelsK1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsStringsLevelsK1StagesEn stages = TranslationsStringsLevelsK1StagesEn._(_root);
}

// Path: strings.levels.k1.stages
class TranslationsStringsLevelsK1StagesEn {
	TranslationsStringsLevelsK1StagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsStringsLevelsK1StagesK1En k1 = TranslationsStringsLevelsK1StagesK1En._(_root);
	late final TranslationsStringsLevelsK1StagesK2En k2 = TranslationsStringsLevelsK1StagesK2En._(_root);
	late final TranslationsStringsLevelsK1StagesK3En k3 = TranslationsStringsLevelsK1StagesK3En._(_root);
}

// Path: strings.levels.k1.stages.k1
class TranslationsStringsLevelsK1StagesK1En {
	TranslationsStringsLevelsK1StagesK1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 1: Introduction';
	String get text => 'This is the first stage. Look at the graph. It consists of two dots and one connection.';
}

// Path: strings.levels.k1.stages.k2
class TranslationsStringsLevelsK1StagesK2En {
	TranslationsStringsLevelsK1StagesK2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 2: More Dots';
	String get text => 'Now there are three dots, and they are connected in a circle.';
}

// Path: strings.levels.k1.stages.k3
class TranslationsStringsLevelsK1StagesK3En {
	TranslationsStringsLevelsK1StagesK3En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 3: Isolated Dot';
	String get text => 'In this stage, one of the dots has no connections.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'strings.settings': return 'Settings';
			case 'strings.statistic': return 'Statistics';
			case 'strings.back': return 'Back';
			case 'strings.useDarkTheme': return 'Темная тема';
			case 'strings.useSeedColor': return 'Основной цвет';
			case 'strings.levels.k1.stages.k1.title': return 'Stage 1: Introduction';
			case 'strings.levels.k1.stages.k1.text': return 'This is the first stage. Look at the graph. It consists of two dots and one connection.';
			case 'strings.levels.k1.stages.k2.title': return 'Stage 2: More Dots';
			case 'strings.levels.k1.stages.k2.text': return 'Now there are three dots, and they are connected in a circle.';
			case 'strings.levels.k1.stages.k3.title': return 'Stage 3: Isolated Dot';
			case 'strings.levels.k1.stages.k3.text': return 'In this stage, one of the dots has no connections.';
			case 'strings.common.next': return 'Далее';
			case 'strings.common.finish': return 'Завершить';
			default: return null;
		}
	}
}

