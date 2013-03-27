# encoding: UTF-8

module DistrictSeed
  puts " -- Adding Districts"

  DictionaryDistrict.find_or_create_by_name(:name => 'Центральный федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Северо-Западный федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Южный федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Северо-Кавказский федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Приволжский федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Уральский федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Сибирский федеральный округ')
  DictionaryDistrict.find_or_create_by_name(:name => 'Дальневосточный федеральный округ')
end
