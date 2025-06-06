#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ПараметрГлавная = Неопределено;
	Если Параметры.Свойство("ГлавнаяЗадача", ПараметрГлавная) Тогда
		Объект.ГлавнаяЗадача = ПараметрГлавная;
	КонецЕсли;

	ПараметрИсточникПараметров = Неопределено;
	Если Параметры.Свойство("ИсточникПараметров", ПараметрИсточникПараметров) Тогда
		ИсточникПараметров = ПараметрИсточникПараметров;
		Центр_ОбработчикиФормыЗадачиСервер.ЗаполнитьНаследуемыеПараметры(ЭтотОбъект, ПараметрИсточникПараметров);
		
		Параметры.Свойство("Исполнитель", Исполнитель);
	КонецЕсли;
	
	ДокОбъект = РеквизитФормыВЗначение("Объект");
	Подписка = ПредопределенноеЗначение(
		"Перечисление.Центр_ПодпискаДляТриггера.ПриСозданииНаСервереФормыЗадачи");
	Центр_ОбработкаТриггеров.ВызовТриггера(Подписка, Объект.Ссылка);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) И ПараметрИсточникПараметров = Неопределено Тогда
		Центр_ОбработчикиФормыЗадачиСервер.ЗаполнитьПользовательскиеНастройки(ЭтотОбъект);
	КонецЕсли;
	
	Выборка = ПолучениеВыборкиМеток();
	Пока Выборка.Следующий() Цикл
		Центр_ЭлементыФормы.СоздатьКоманду(ЭтотОбъект,
										   "МеткаКоманда" + Выборка.Код,
										   Выборка.Наименование,
										   "ПрисвоитьЗначениеМетке");
		
		НоваяКнопка = Центр_ЭлементыФормы.СздКнопка(ЭтотОбъект,
													"МеткаКоманда" + Выборка.Код,
													Элементы.Метки,
													Выборка.Наименование,
													"МеткаКоманда" + Выборка.Код);
		НоваяКнопка.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Лево;
		Элементы.Переместить(Элементы["МеткаКоманда" + Выборка.Код], Элементы.Метки, Элементы.Еще);
		НоваяКнопка.Фигура = ФигураКнопки.Овал;
		
		Цвет = Выборка.ЦветRGB;
		Если ЗначениеЗаполнено(Цвет) Тогда
			Фон = СтрРазделить(Цвет, ",");
			//@skip-check new-color
			НоваяКнопка.ЦветФона = Новый Цвет(Фон[0], Фон[1], Фон[2]);
		КонецЕсли;

		СтрокаТаблицы = ТаблицаМеток.Добавить();
		СтрокаТаблицы.Команда = "МеткаКоманда" + Выборка.Код;
		СтрокаТаблицы.Код = Выборка.Код;

	КонецЦикла;	

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Если ПараметрыЗаписи.Свойство("НеСохранять") Тогда
		Отказ = Истина;
		Модифицированность = Ложь;
		Закрыть();
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	Запрос = Новый Запрос;
    Запрос.Текст =
    "ВЫБРАТЬ
    |    Центр_ИсполнителиЗадачСрезПоследних.Исполнитель
    |ИЗ
    |    РегистрСведений.Центр_ИсполнителиЗадач.СрезПоследних(, Задача = &Задача) КАК Центр_ИсполнителиЗадачСрезПоследних";

    Запрос.УстановитьПараметр("Задача", ТекущийОбъект.Ссылка);

    РезультатЗапроса = Запрос.Выполнить();

    Выборка = РезультатЗапроса.Выбрать();

    Если Не РезультатЗапроса.Пустой() Тогда
        Если Выборка.Следующий() Тогда
            Если Исполнитель <> Выборка.Исполнитель Тогда
                МенеджерЗаписи = РегистрыСведений.Центр_ИсполнителиЗадач.СоздатьМенеджерЗаписи();
                МенеджерЗаписи.Исполнитель = Исполнитель;
                МенеджерЗаписи.Задача = ТекущийОбъект.Ссылка;
                МенеджерЗаписи.Период = ТекущаяДатаСеанса();
                МенеджерЗаписи.Записать();
            КонецЕсли;
        КонецЕсли;
    Иначе
        МенеджерЗаписи = РегистрыСведений.Центр_ИсполнителиЗадач.СоздатьМенеджерЗаписи();
        МенеджерЗаписи.Задача = ТекущийОбъект.Ссылка;
        МенеджерЗаписи.Исполнитель = Исполнитель;
        МенеджерЗаписи.Период = ТекущаяДатаСеанса();
        МенеджерЗаписи.Записать();
    КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.ОписаниеЗадачи = Новый ХранилищеЗначения(ОписаниеЗадачиДокумент);
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ОткрытьПолнуюФорму(Команда)
	
	АдресОписанияЗадачи = ПоместитьВоВременноеХранилище(ОписаниеЗадачиДокумент);
	
	ПараметрыФормы = Новый Структура("НаименованиеЗадачи,ГлавнаяЗадача,ИсточникПараметров,ОписаниеЗадачи,Ключ,Метка",
		Объект.Наименование, Объект.ГлавнаяЗадача, ИсточникПараметров, АдресОписанияЗадачи, Объект.Ссылка, Объект.Метка);
		
	ФормаДок = ПолучитьФорму("Документ.Центр_Задача.Форма.ФормаДокумента", ПараметрыФормы);
	
	Если ОписаниеОповещенияОЗакрытии <> Неопределено Тогда
		ДанныеФормы = ФормаДок.Объект;
		
		ПараметрыДоп = Новый Структура("ФормаДок", ФормаДок);
		НовыйООЗ = Новый ОписаниеОповещения(ОписаниеОповещенияОЗакрытии.ИмяПроцедуры, ОписаниеОповещенияОЗакрытии.Модуль, 
			ПараметрыДоп);
	
		СоздатьГлавнуюЗадачуНаСервере(ДанныеФормы);
		ФормаДок.ОписаниеОповещенияОЗакрытии = НовыйООЗ;
	КонецЕсли;

	ФормаДок.Открыть();

	ОписаниеОповещенияОЗакрытии = Неопределено;
	ПараметрыЗакрытия = Новый Структура("НеСохранять", Истина);
	//@skip-check invocation-form-event-handler
	ПередЗаписью(Ложь, ПараметрыЗакрытия);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Функция СоздатьГлавнуюЗадачуНаСервере(ДанныеФормы)	
	Док = Документы.Центр_Задача.СоздатьДокумент();
	Док.УстановитьСсылкуНового(Объект.Ссылка);
	ЗначениеВДанныеФормы(Док, ДанныеФормы);
	Возврат  Объект.Ссылка; 
КонецФункции
#КонецОбласти

#Область Метки

&НаСервере
Функция ПолучениеВыборкиМеток()
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ПРЕДСТАВЛЕНИЕ(Центр_МеткиЗадач.Наименование) КАК Наименование,
		|	Центр_МеткиЗадач.ЦветRGB,
		|	ПРЕДСТАВЛЕНИЕ(Центр_МеткиЗадач.Код) КАК Код
		|ИЗ
		|	Справочник.Центр_МеткиЗадач КАК Центр_МеткиЗадач
		|ГДЕ
		|	Центр_МеткиЗадач.ВидимостьНаФорме = ИСТИНА";
	
	Возврат Запрос.Выполнить().Выбрать();
КонецФункции

&НаКлиенте
Процедура ПрисвоитьЗначениеМетке(Команда)
	ПараметрыМетки = Новый Структура("Команда", Команда.Имя);
	СтрокаМетки = ТаблицаМеток.НайтиСтроки(ПараметрыМетки);	
	ПрисвоитьЗначениеМеткеНаСервере(СтрокаМетки[0].Код);
КонецПроцедуры

&НаСервере
Процедура ПрисвоитьЗначениеМеткеНаСервере(КодМетки)	
	Метка = Справочники.Центр_МеткиЗадач.НайтиПоКоду(КодМетки);
	Объект.Метка = Метка;
	ПослеВыбораМеткиНаСервере(Метка);
	Элементы.Еще.Видимость = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ВызовВыбораМеток()
	ОписаниеОповещенияОЗакрытииФормыВыбора = Новый ОписаниеОповещения("ПослеВыбораМетки", ЭтотОбъект);
	ОткрытьФорму("Справочник.Центр_МеткиЗадач.ФормаВыбора",,,,,,ОписаниеОповещенияОЗакрытииФормыВыбора,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораМетки(Результат, ДополнительныеПараметры) Экспорт
	Если НЕ ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;

	ПослеВыбораМеткиНаСервере(Результат);
	Объект.Метка = Результат;
	Элементы.Еще.Видимость = Ложь;	
КонецПроцедуры

&НаСервере
Процедура ПослеВыбораМеткиНаСервере(МеткаСсылка)
	Для Каждого СтрокаМетки Из ТаблицаМеток Цикл
		ИмяКоманды = СтрокаМетки.Команда;
		Элементы.Удалить(Элементы[ИмяКоманды]);
	КонецЦикла;
	
	Элемент = Элементы.Найти("ДекорацияМетки");
	Если Элемент <> Неопределено Тогда
		Элементы.Удалить(Элемент);
	КонецЕсли;
	
	ТаблицаМеток.Очистить();
	
	RGBМетки = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(МеткаСсылка, "ЦветRGB");
	НаименованиеМетки = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(МеткаСсылка, "Наименование");

	ДекорацияМетки = Элементы.Добавить("ДекорацияМетки", Тип("ДекорацияФормы"), Элементы.Метки);
	ДекорацияМетки.Вид = ВидДекорацииФормы.Надпись;
	ДекорацияМетки.Заголовок = НаименованиеМетки;

	Цвет = RGBМетки;
	Если ЗначениеЗаполнено(Цвет) Тогда
		Фон = СтрРазделить(Цвет, ",");
			//@skip-check new-color
		ДекорацияМетки.ЦветФона = Новый Цвет(Фон[0], Фон[1], Фон[2]);
	КонецЕсли;
	
	Центр_ЭлементыФормы.СздКнопка(ЭтотОбъект,
								  "КонтекстноеМенюОчистить",
								  Элементы["ДекорацияМетки"].КонтекстноеМеню,
								  "Очистить",
								  "КонтекстноеМенюОчистить");
	
	Центр_ЭлементыФормы.СздКнопка(ЭтотОбъект,
								  "КонтекстноеМенюИзменить",
								  Элементы["ДекорацияМетки"].КонтекстноеМеню,
								  "Изменить",
								  "КонтекстноеМенюИзменить");
	
	Элемент = Элементы.Найти("ВыборМеткиКнопка");
	Если Элемент <> Неопределено Тогда
		Элементы.Удалить(Элемент);
	КонецЕсли;
							  																																	
КонецПроцедуры

&НаКлиенте
Процедура ОчисткаМетокНаФорме(Команда)
	ОчисткаМетокНаФормеНаСервере();	
	Объект.Метка = Неопределено;
КонецПроцедуры

&НаСервере
Процедура ОчисткаМетокНаФормеНаСервере()
	Элемент = Элементы.Найти("ДекорацияМетки");
	Если Элемент <> Неопределено Тогда
		Элементы.Удалить(Элемент);
	КонецЕсли;
	
	Центр_ЭлементыФормы.СздКнопка(ЭтотОбъект, "ВыборМеткиКнопка", Элементы.Метки, "Метки", "МеткаЕщё", 2);	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеМетокНаФорме(Команда)
	ВызовВыбораМеток();	
КонецПроцедуры

&НаКлиенте
Процедура МеткаЕщё(Команда)
	ВызовВыбораМеток();	
КонецПроцедуры	
#КонецОбласти
