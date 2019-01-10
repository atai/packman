#Использовать logos

Перем Лог;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Прикладной интерфейс

Процедура ЗарегистрироватьКоманду(Знач ИмяКоманды, Знач Парсер) Экспорт
	ОписаниеКоманды = Парсер.ОписаниеКоманды(ИмяКоманды, "Подключение существующей ИБ как рабочей");
	Парсер.ДобавитьПозиционныйПараметрКоманды(ОписаниеКоманды, "ibconnection", "Строка подключения к БД (/FfilePath или /SserverPath)	Например, для файловых баз --ibconnection /FC:\base1 или --ibconnection /F./base1 или --ibconnection /Fbase1 Или для серверных баз --ibconnection /Sservername\basename"); // позиционный
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "-db-user", "Пользователь БД");
	Парсер.ДобавитьИменованныйПараметрКоманды(ОписаниеКоманды, "-db-pwd", "Пароль БД");
	Парсер.ДобавитьКоманду(ОписаниеКоманды);
КонецПроцедуры

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие ключей командной строки и их значений
//
Функция ВыполнитьКоманду(Знач ПараметрыКоманды) Экспорт
	ПутьКФайлуКонфигурации = ОкружениеСборки.ПолучитьПутьКФайлуКонфигурации();
	СтрокаПодключения = ПараметрыКоманды["ibconnection"];
	ПользовательИБ = ПараметрыКоманды["-db-user"];
	ПарольИБ = ПараметрыКоманды["-db-pwd"];
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.ДобавитьСтроку("СтрокаПодключения" + "=" + СтрокаПодключения);
	Если ПользовательИБ <> Неопределено Тогда
		ТекстовыйДокумент.ДобавитьСтроку("ПользовательИБ" + "=" + ПользовательИБ);
		Если ПарольИБ <> Неопределено  Тогда
			ТекстовыйДокумент.ДобавитьСтроку("ПарольИБ" + "=" + ПарольИБ);
		КонецЕсли;
	КонецЕсли;
			
	ТекстовыйДокумент.Записать(ПутьКФайлуКонфигурации);

	Лог.Информация("Файл настройки подключения создан. %1", ПутьКФайлуКонфигурации);
	Возврат 0;
	
КонецФункции

Лог = Логирование.ПолучитьЛог(ПараметрыСистемы.ИмяЛогаСистемы());