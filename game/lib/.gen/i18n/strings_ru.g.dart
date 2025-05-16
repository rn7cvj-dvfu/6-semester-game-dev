///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsStringsRu strings = _TranslationsStringsRu._(_root);
}

// Path: strings
class _TranslationsStringsRu implements TranslationsStringsEn {
	_TranslationsStringsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Настройки';
	@override String get statistic => 'Статистика';
	@override String get back => 'Назад';
	@override String get useDarkTheme => 'Темная тема';
	@override String get useSeedColor => 'Основной цвет';
	@override late final _TranslationsStringsLevelsRu levels = _TranslationsStringsLevelsRu._(_root);
	@override late final _TranslationsStringsCommonRu common = _TranslationsStringsCommonRu._(_root);
}

// Path: strings.levels
class _TranslationsStringsLevelsRu implements TranslationsStringsLevelsEn {
	_TranslationsStringsLevelsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsStringsLevelsK1Ru k1 = _TranslationsStringsLevelsK1Ru._(_root);
}

// Path: strings.common
class _TranslationsStringsCommonRu implements TranslationsStringsCommonEn {
	_TranslationsStringsCommonRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get next => 'Далее';
	@override String get finish => 'Завершить';
}

// Path: strings.levels.k1
class _TranslationsStringsLevelsK1Ru implements TranslationsStringsLevelsK1En {
	_TranslationsStringsLevelsK1Ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsStringsLevelsK1StagesRu stages = _TranslationsStringsLevelsK1StagesRu._(_root);
}

// Path: strings.levels.k1.stages
class _TranslationsStringsLevelsK1StagesRu implements TranslationsStringsLevelsK1StagesEn {
	_TranslationsStringsLevelsK1StagesRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsStringsLevelsK1StagesK1Ru k1 = _TranslationsStringsLevelsK1StagesK1Ru._(_root);
	@override late final _TranslationsStringsLevelsK1StagesK2Ru k2 = _TranslationsStringsLevelsK1StagesK2Ru._(_root);
	@override late final _TranslationsStringsLevelsK1StagesK3Ru k3 = _TranslationsStringsLevelsK1StagesK3Ru._(_root);
}

// Path: strings.levels.k1.stages.k1
class _TranslationsStringsLevelsK1StagesK1Ru implements TranslationsStringsLevelsK1StagesK1En {
	_TranslationsStringsLevelsK1StagesK1Ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Этап 1: Точка';
	@override String get text => 'Это точка. Просто одинокая точка на чистом холсте. Идите дальше.';
}

// Path: strings.levels.k1.stages.k2
class _TranslationsStringsLevelsK1StagesK2Ru implements TranslationsStringsLevelsK1StagesK2En {
	_TranslationsStringsLevelsK1StagesK2Ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Этап 2: Ребро';
	@override String get text => 'Точек стало больше. Теперь они соединены ребром. Из него Адам.. так стоп';
}

// Path: strings.levels.k1.stages.k3
class _TranslationsStringsLevelsK1StagesK3Ru implements TranslationsStringsLevelsK1StagesK3En {
	_TranslationsStringsLevelsK1StagesK3Ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Этап 3: Граф';
	@override String get text => 'Когда соединённых точек много, они образуют граф.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'strings.settings': return 'Настройки';
			case 'strings.statistic': return 'Статистика';
			case 'strings.back': return 'Назад';
			case 'strings.useDarkTheme': return 'Темная тема';
			case 'strings.useSeedColor': return 'Основной цвет';
			case 'strings.levels.k1.stages.k1.title': return 'Этап 1: Точка';
			case 'strings.levels.k1.stages.k1.text': return 'Это точка. Просто одинокая точка на чистом холсте. Идите дальше.';
			case 'strings.levels.k1.stages.k2.title': return 'Этап 2: Ребро';
			case 'strings.levels.k1.stages.k2.text': return 'Точек стало больше. Теперь они соединены ребром. Из него Адам.. так стоп';
			case 'strings.levels.k1.stages.k3.title': return 'Этап 3: Граф';
			case 'strings.levels.k1.stages.k3.text': return 'Когда соединённых точек много, они образуют граф.';
			case 'strings.common.next': return 'Далее';
			case 'strings.common.finish': return 'Завершить';
			default: return null;
		}
	}
}

