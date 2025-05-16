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
	String get useDarkTheme => 'Dark theme';
	String get useSeedColor => 'Seed color';
	String get useLangue => 'Language';
	late final TranslationsStringsLevelsEn levels = TranslationsStringsLevelsEn._(_root);
	String get enterNumberOfConnectivityComponents => 'Enter the number of connected components';
	late final TranslationsStringsCommonEn common = TranslationsStringsCommonEn._(_root);
}

// Path: strings.levels
class TranslationsStringsLevelsEn {
	TranslationsStringsLevelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsStringsLevelsK1En k1 = TranslationsStringsLevelsK1En._(_root);
	late final TranslationsStringsLevelsK2En k2 = TranslationsStringsLevelsK2En._(_root);
}

// Path: strings.common
class TranslationsStringsCommonEn {
	TranslationsStringsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get back => 'Back';
	String get next => 'Далее';
	String get finish => 'Завершить';
}

// Path: strings.levels.k1
class TranslationsStringsLevelsK1En {
	TranslationsStringsLevelsK1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Basics';
	late final TranslationsStringsLevelsK1StagesEn stages = TranslationsStringsLevelsK1StagesEn._(_root);
}

// Path: strings.levels.k2
class TranslationsStringsLevelsK2En {
	TranslationsStringsLevelsK2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'Connectivity components';
	late final TranslationsStringsLevelsK2StagesEn stages = TranslationsStringsLevelsK2StagesEn._(_root);
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

// Path: strings.levels.k2.stages
class TranslationsStringsLevelsK2StagesEn {
	TranslationsStringsLevelsK2StagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsStringsLevelsK2StagesK1En k1 = TranslationsStringsLevelsK2StagesK1En._(_root);
	late final TranslationsStringsLevelsK2StagesK2En k2 = TranslationsStringsLevelsK2StagesK2En._(_root);
	late final TranslationsStringsLevelsK2StagesK3En k3 = TranslationsStringsLevelsK2StagesK3En._(_root);
	late final TranslationsStringsLevelsK2StagesK4En k4 = TranslationsStringsLevelsK2StagesK4En._(_root);
}

// Path: strings.levels.k1.stages.k1
class TranslationsStringsLevelsK1StagesK1En {
	TranslationsStringsLevelsK1StagesK1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 1: Dot';
	String get text => 'This is a dot. It\'s just a single dot on a blank canvas. Move on.';
}

// Path: strings.levels.k1.stages.k2
class TranslationsStringsLevelsK1StagesK2En {
	TranslationsStringsLevelsK1StagesK2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 2: Edge';
	String get text => 'There are more dots now. They are connected by an edge. From it Adam.. stop';
}

// Path: strings.levels.k1.stages.k3
class TranslationsStringsLevelsK1StagesK3En {
	TranslationsStringsLevelsK1StagesK3En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 3: Graph';
	String get text => 'When there are many connected dots, they form a graph.';
}

// Path: strings.levels.k2.stages.k1
class TranslationsStringsLevelsK2StagesK1En {
	TranslationsStringsLevelsK2StagesK1En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 1: Connected graph';
	String get text => 'This graph is connected. It means you can reach any vertex from any other by following the edges.';
}

// Path: strings.levels.k2.stages.k2
class TranslationsStringsLevelsK2StagesK2En {
	TranslationsStringsLevelsK2StagesK2En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 2: Disconnected graph';
	String get text => 'This graph is not connected. It consists of two separate parts, called connected components. You cannot move from one part to another.';
}

// Path: strings.levels.k2.stages.k3
class TranslationsStringsLevelsK2StagesK3En {
	TranslationsStringsLevelsK2StagesK3En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 3: Connected components';
	String get text => 'Here are three connected components. Each component is a maximal connected subgraph. Inside each component, all vertices are connected, but there are no connections between different components.';
}

// Path: strings.levels.k2.stages.k4
class TranslationsStringsLevelsK2StagesK4En {
	TranslationsStringsLevelsK2StagesK4En._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Stage 4: How many connected components?';
	String get text => 'Here is a graph with several connected components. How many are there?';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'strings.settings': return 'Settings';
			case 'strings.statistic': return 'Statistics';
			case 'strings.useDarkTheme': return 'Dark theme';
			case 'strings.useSeedColor': return 'Seed color';
			case 'strings.useLangue': return 'Language';
			case 'strings.levels.k1.name': return 'Basics';
			case 'strings.levels.k1.stages.k1.title': return 'Stage 1: Dot';
			case 'strings.levels.k1.stages.k1.text': return 'This is a dot. It\'s just a single dot on a blank canvas. Move on.';
			case 'strings.levels.k1.stages.k2.title': return 'Stage 2: Edge';
			case 'strings.levels.k1.stages.k2.text': return 'There are more dots now. They are connected by an edge. From it Adam.. stop';
			case 'strings.levels.k1.stages.k3.title': return 'Stage 3: Graph';
			case 'strings.levels.k1.stages.k3.text': return 'When there are many connected dots, they form a graph.';
			case 'strings.levels.k2.name': return 'Connectivity components';
			case 'strings.levels.k2.stages.k1.title': return 'Stage 1: Connected graph';
			case 'strings.levels.k2.stages.k1.text': return 'This graph is connected. It means you can reach any vertex from any other by following the edges.';
			case 'strings.levels.k2.stages.k2.title': return 'Stage 2: Disconnected graph';
			case 'strings.levels.k2.stages.k2.text': return 'This graph is not connected. It consists of two separate parts, called connected components. You cannot move from one part to another.';
			case 'strings.levels.k2.stages.k3.title': return 'Stage 3: Connected components';
			case 'strings.levels.k2.stages.k3.text': return 'Here are three connected components. Each component is a maximal connected subgraph. Inside each component, all vertices are connected, but there are no connections between different components.';
			case 'strings.levels.k2.stages.k4.title': return 'Stage 4: How many connected components?';
			case 'strings.levels.k2.stages.k4.text': return 'Here is a graph with several connected components. How many are there?';
			case 'strings.enterNumberOfConnectivityComponents': return 'Enter the number of connected components';
			case 'strings.common.back': return 'Back';
			case 'strings.common.next': return 'Далее';
			case 'strings.common.finish': return 'Завершить';
			default: return null;
		}
	}
}

