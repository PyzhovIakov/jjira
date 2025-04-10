// Обновляет запись в кэше напоминаний текущего пользователя.
Процедура ОбновитьЗаписьВКэшеОповещений(ПараметрыОповещения) Экспорт
	//КэшОповещений = НастройкиНаКлиенте().СписокТекущихНапоминаний;
	//Запись = НайтиЗаписьВКэшеОповещений(КэшОповещений, ПараметрыОповещения);
	//Если Запись <> Неопределено Тогда
	//	ЗаполнитьЗначенияСвойств(Запись, ПараметрыОповещения);
	//Иначе
	//	КэшОповещений.Добавить(ПараметрыОповещения);
	//КонецЕсли;
КонецПроцедуры


// Удаляет запись из кэша напоминаний текущего пользователя.
Процедура УдалитьЗаписьИзКэшаОповещений(ПараметрыОповещения) Экспорт
	//КэшОповещений = НастройкиНаКлиенте().СписокТекущихНапоминаний;
	//Запись = НайтиЗаписьВКэшеОповещений(КэшОповещений, ПараметрыОповещения);
	//Если Запись <> Неопределено Тогда
	//	КэшОповещений.Удалить(КэшОповещений.Найти(Запись));
	//КонецЕсли;
КонецПроцедуры

Функция ПредставлениеВремениДокументооборот(Время) Экспорт
	
	Если Время = 0 Тогда
		Возврат НСтр("ru = 'при наступлении события'");
	Иначе
		ПредставлениеВремени = ПредставлениеВремени(Время);
		ПредставлениеПредлога = НСтр("ru = 'за'");
		Возврат СтрШаблон(НСтр("ru = '%1 %2'"), ПредставлениеПредлога, ПредставлениеВремени);
	КонецЕсли;
	
КонецФункции



// Получает из текстового описания интервал времени в секундах.
//
// Параметры:
//  СтрокаСоВременем - Строка - текстовое описание времени, где числа записаны цифрами,
//								а единицы измерения - строкой. 
//
// Возвращаемое значение:
//  Число - интервал времени в секундах.
// 
Функция ИнтервалВремени(Знач СтрокаСоВременем) Экспорт
	//
	//Если ПустаяСтрока(СтрокаСоВременем) Тогда
	//	Возврат 0;
	//КонецЕсли;
	//
	//СтрокаСоВременем = НРег(СтрокаСоВременем);
	//СтрокаСоВременем = СтрЗаменить(СтрокаСоВременем, Символы.НПП," ");
	//СтрокаСоВременем = СтрЗаменить(СтрокаСоВременем, ".",",");
	//СтрокаСоВременем = СтрЗаменить(СтрокаСоВременем, "+","");
	//
	//ПодстрокаСЦифрами = "";
	//ПодстрокаСБуквами = "";
	//
	//ПредыдущийСимволЭтоЦифра = Ложь;
	//ЕстьДробнаяЧасть = Ложь;
	//
	//Результат = 0;
	//Для Позиция = 1 По СтрДлина(СтрокаСоВременем) Цикл
	//	ТекущийКодСимвола = КодСимвола(СтрокаСоВременем,Позиция);
	//	Символ = Сред(СтрокаСоВременем,Позиция,1);
	//	Если (ТекущийКодСимвола >= КодСимвола("0") И ТекущийКодСимвола <= КодСимвола("9"))
	//		ИЛИ (Символ="," И ПредыдущийСимволЭтоЦифра И Не ЕстьДробнаяЧасть) Тогда
	//		Если Не ПустаяСтрока(ПодстрокаСБуквами) Тогда
	//			ПодстрокаСЦифрами = СтрЗаменить(ПодстрокаСЦифрами,",",".");
	//			Результат = Результат + ?(ПустаяСтрока(ПодстрокаСЦифрами), 1, Число(ПодстрокаСЦифрами))
	//				* ЗаменитьЕдиницуИзмеренияНаМножитель(ПодстрокаСБуквами);
	//				
	//			ПодстрокаСЦифрами = "";
	//			ПодстрокаСБуквами = "";
	//			
	//			ПредыдущийСимволЭтоЦифра = Ложь;
	//			ЕстьДробнаяЧасть = Ложь;
	//		КонецЕсли;
	//		
	//		ПодстрокаСЦифрами = ПодстрокаСЦифрами + Сред(СтрокаСоВременем,Позиция,1);
	//		
	//		ПредыдущийСимволЭтоЦифра = Истина;
	//		Если Символ = "," Тогда
	//			ЕстьДробнаяЧасть = Истина;
	//		КонецЕсли;
	//	Иначе
	//		Если Символ = " " И ЗаменитьЕдиницуИзмеренияНаМножитель(ПодстрокаСБуквами) = "0" Тогда
	//			ПодстрокаСБуквами = "";
	//		КонецЕсли;
	//		
	//		ПодстрокаСБуквами = ПодстрокаСБуквами + Сред(СтрокаСоВременем,Позиция,1);
	//		ПредыдущийСимволЭтоЦифра = Ложь;
	//	КонецЕсли;
	//КонецЦикла;
	//
	//Если Не ПустаяСтрока(ПодстрокаСБуквами) Тогда
	//	ПодстрокаСЦифрами = СтрЗаменить(ПодстрокаСЦифрами,",",".");
	//	Результат = Результат + ?(ПустаяСтрока(ПодстрокаСЦифрами), 1, Число(ПодстрокаСЦифрами))
	//		* ЗаменитьЕдиницуИзмеренияНаМножитель(ПодстрокаСБуквами);
	//КонецЕсли;
	//
	//Возврат Результат;
	
КонецФункции


  
// Возвращает текстовое представление интервала времени, заданного в секундах.
//
// Параметры:
//
//  Время - Число - интервал времени в секундах.
//
//  ПолноеПредставление	- Булево - кратное или полное представление времени.
//		Например, интервал 1 000 000 секунд:
//		- полное представление:  11 дней 13 часов 46 минут 40 секунд;
//		- краткое представление: 11 дней 13 часов.
//  
//  ВыводитьСекунды - Булево - Ложь, если секунды не требуются.
//  
// Возвращаемое значение:
//   Строка - представление интервала времени.
//
Функция ПредставлениеВремени(Знач Время, ПолноеПредставление = Истина, ВыводитьСекунды = Истина) Экспорт
	Результат = "";
	
	// Представление единиц измерения времени в винительном падеже для количеств: 1, 2-4, 5-20.
	ПредставлениеНедель = НСтр("ru = ';%1 неделю;;%1 недели;%1 недель;%1 недели'");
	ПредставлениеДней   = НСтр("ru = ';%1 день;;%1 дня;%1 дней;%1 дня'");
	ПредставлениеЧасов  = НСтр("ru = ';%1 час;;%1 часа;%1 часов;%1 часа'");
	ПредставлениеМинут  = НСтр("ru = ';%1 минуту;;%1 минуты;%1 минут;%1 минуты'");
	ПредставлениеСекунд = НСтр("ru = ';%1 секунду;;%1 секунды;%1 секунд;%1 секунды'");
	
	Время = Число(Время);
	
	Если Время < 0 Тогда
		Время = -Время;
	КонецЕсли;
	
	КоличествоНедель = Цел(Время / 60/60/24/7);
	КоличествоДней   = Цел(Время / 60/60/24);
	КоличествоЧасов  = Цел(Время / 60/60);
	КоличествоМинут  = Цел(Время / 60);
	КоличествоСекунд = Цел(Время);
	
	КоличествоСекунд = КоличествоСекунд - КоличествоМинут * 60;
	КоличествоМинут  = КоличествоМинут - КоличествоЧасов * 60;
	КоличествоЧасов  = КоличествоЧасов - КоличествоДней * 24;
	КоличествоДней   = КоличествоДней - КоличествоНедель * 7;
	
	Если Не ВыводитьСекунды Тогда
		КоличествоСекунд = 0;
	КонецЕсли;
	
	Если КоличествоНедель > 0 И КоличествоДней+КоличествоЧасов+КоличествоМинут+КоличествоСекунд=0 Тогда
		Результат = СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеНедель, КоличествоНедель);
	Иначе
		КоличествоДней = КоличествоДней + КоличествоНедель * 7;
		
		Счетчик = 0;
		Если КоличествоДней > 0 Тогда
			Результат = Результат + СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеДней, КоличествоДней) + " ";
			Счетчик = Счетчик + 1;
		КонецЕсли;
		
		Если КоличествоЧасов > 0 Тогда
			Результат = Результат + СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеЧасов, КоличествоЧасов) + " ";
			Счетчик = Счетчик + 1;
		КонецЕсли;
		
		Если (ПолноеПредставление Или Счетчик < 2) И КоличествоМинут > 0 Тогда
			Результат = Результат + СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеМинут, КоличествоМинут) + " ";
			Счетчик = Счетчик + 1;
		КонецЕсли;
		
		Если (ПолноеПредставление Или Счетчик < 2) И (КоличествоСекунд > 0 Или КоличествоНедель+КоличествоДней+КоличествоЧасов+КоличествоМинут = 0) Тогда
			Результат = Результат + СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеСекунд, КоличествоСекунд);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат СокрП(Результат);
	
КонецФункции


// Создает новое напоминание на время, рассчитанное относительно времени в предмете.
Функция ПодключитьНапоминаниеДоВремениПредмета(Текст, Интервал, Предмет, ИмяРеквизита,
	ВремяСобытия = Неопределено, Пользователь = Неопределено) Экспорт
	
	ПараметрыНапоминания = Новый Структура;
	ПараметрыНапоминания.Вставить("Описание", Текст);
	ПараметрыНапоминания.Вставить("Источник", Предмет);
	ПараметрыНапоминания.Вставить("ИмяРеквизитаИсточника", ИмяРеквизита);
	ПараметрыНапоминания.Вставить("ИнтервалВремениНапоминания", Интервал);
	Если ЗначениеЗаполнено(Пользователь) Тогда
		ПараметрыНапоминания.Вставить("Пользователь", Пользователь);
	КонецЕсли;
	
	//Напоминание = НапоминанияПользователяСлужебный.СоздатьНапоминание(ПараметрыНапоминания, ВремяСобытия);
	//НапоминанияПользователяСлужебный.ПодключитьНапоминание(Напоминание);
	//
	//Возврат Напоминание;
	//
КонецФункции



