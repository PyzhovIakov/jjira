///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Возвращает Истина если есть субъекты, для которых необходимо рассчитать сроки хранения персональных данных,
// иначе - Ложь.
// 
// Возвращаемое значение:
//  Булево 
//
Функция ЕстьСубъектыДляРасчетаСроковХранения() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	ИСТИНА
		|ИЗ
		|	РегистрСведений.СубъектыДляРасчетаСроковХранения КАК СубъектыДляРасчетаСроковХранения";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат Не РезультатЗапроса.Пустой();
	
КонецФункции

// Возвращает первых 10000 субъектов, для которых необходимо рассчитать сроки хранения персональных данных.
// 
// Возвращаемое значение: см. ЗащитаПерсональныхДанных.НоваяТаблицаДляРасчетаСроковХранения
//
Функция СубъектыДляРасчетаСроковХранения() Экспорт
	
	Субъекты = ЗащитаПерсональныхДанных.НоваяТаблицаДляРасчетаСроковХранения();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ ПЕРВЫЕ 10000
		|	СубъектыДляРасчетаСроковХранения.Субъект,
		|	СубъектыДляРасчетаСроковХранения.ДатаСобытия
		|ИЗ
		|	РегистрСведений.СубъектыДляРасчетаСроковХранения КАК СубъектыДляРасчетаСроковХранения";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Субъекты;
	КонецЕсли;
	
	Субъекты = РезультатЗапроса.Выгрузить();
	Субъекты.Индексы.Добавить("Субъект");
		
	Возврат Субъекты;
	
КонецФункции

#КонецОбласти

#КонецЕсли
