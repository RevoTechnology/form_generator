# encoding: UTF-8

module RegionSeed
  #puts is not there
  #puts " -- Adding districts"
  #TODO разобраться с этими полями
  DictionaryRegion.find_or_create_by_name(:name => 'Таймырский (Долгано-Ненецкий) АО', :dictionary_district_id => 0)
  DictionaryRegion.find_or_create_by_name(:name => 'Эвенкийский АО', :dictionary_district_id => 0)

  #puts " -- -- district 1"
  DictionaryRegion.find_or_create_by_name(:name => 'Москва', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Ярославская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Тульская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Тверская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Тамбовская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Смоленская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Рязанская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Орловская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Московская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Курская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Липецкая область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Костромская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Калужская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Ивановская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Воронежская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Владимирская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Брянская область', :dictionary_district_id => 1)
  DictionaryRegion.find_or_create_by_name(:name => 'Белгородская область', :dictionary_district_id => 1)

  #puts " -- -- district 2"
  DictionaryRegion.find_or_create_by_name(:name => 'Новгородская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Мурманская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Ленинградская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Калининградская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Вологодская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Ненецкий автономный округ', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Архангельская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Коми', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Карелия', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Псковская область', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Санкт-Петербург', :dictionary_district_id => 2)
  DictionaryRegion.find_or_create_by_name(:name => 'Ненецкий АО', :dictionary_district_id => 2)


  #puts " -- -- district 3"
  DictionaryRegion.find_or_create_by_name(:name => 'Ростовская область', :dictionary_district_id => 3)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Дагестан', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Астраханская область', :dictionary_district_id => 3)
  DictionaryRegion.find_or_create_by_name(:name => 'Волгоградская область', :dictionary_district_id => 3)
  DictionaryRegion.find_or_create_by_name(:name => 'Краснодарский край', :dictionary_district_id => 3)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Калмыкия', :dictionary_district_id => 3)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Адыгея', :dictionary_district_id => 3)

  #puts " -- -- district 4"
  DictionaryRegion.find_or_create_by_name(:name => 'Ставропольский край', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Чеченская Республика', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Карачаево-Черкесия', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Северная Осетия', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Кабардино-Балкария', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Ингушетия', :dictionary_district_id => 4)
  DictionaryRegion.find_or_create_by_name(:name => 'Карачаево-Черкесия', :dictionary_district_id => 4)

  #puts " -- -- district 5"
  DictionaryRegion.find_or_create_by_name(:name => 'Ульяновская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Саратовская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Самарская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Пензенская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Оренбургская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Пермский край', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Кировская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Нижегородская область', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Чувашская Республика', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Удмуртская Республика', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Татарстан', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Марий Эл', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Мордовия', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Башкортостан', :dictionary_district_id => 5)
  DictionaryRegion.find_or_create_by_name(:name => 'Коми-Пермяцкий АО', :dictionary_district_id => 5)

  #puts " -- -- district 6"
  DictionaryRegion.find_or_create_by_name(:name => 'Ямало-Ненецкий АО', :dictionary_district_id => 6)
  DictionaryRegion.find_or_create_by_name(:name => 'Челябинская область', :dictionary_district_id => 6)
  DictionaryRegion.find_or_create_by_name(:name => 'Ханты-Мансийский АО', :dictionary_district_id => 6)
  DictionaryRegion.find_or_create_by_name(:name => 'Тюменская область', :dictionary_district_id => 6)
  DictionaryRegion.find_or_create_by_name(:name => 'Свердловская область', :dictionary_district_id => 6)
  DictionaryRegion.find_or_create_by_name(:name => 'Курганская область', :dictionary_district_id => 6)

  #puts " -- -- district 7"
  DictionaryRegion.find_or_create_by_name(:name => 'Омская область', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Кемеровская область', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Новосибирская область', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Иркутская область', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Красноярский край', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Алтайский край', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Хакасия', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Алтай', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Бурятия', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Тыва (Тува)', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Читинская область', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Агинский Бурятский АО', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Усть-Ордынский Бурятский АО', :dictionary_district_id => 7)

  #puts " -- -- district 8"
  DictionaryRegion.find_or_create_by_name(:name => 'Амурская область', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Чукотский АО', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Сахалинская область', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Еврейская автономная область', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Магаданская область', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Приморский край', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Хабаровский край', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Томская область', :dictionary_district_id => 7)
  DictionaryRegion.find_or_create_by_name(:name => 'Республика Саха (Якутия)', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Камчатская область', :dictionary_district_id => 8)
  DictionaryRegion.find_or_create_by_name(:name => 'Корякский АО', :dictionary_district_id => 8)
end
