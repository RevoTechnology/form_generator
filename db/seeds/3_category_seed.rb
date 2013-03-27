# encoding: UTF-8

module CategorySeed
  puts " -- Creating categories"
  Category.find_or_create_by_name(:name => "Контактная информация")
  Category.find_or_create_by_name(:name => "Адрес проживания")
  Category.find_or_create_by_name(:name => "Паспортные данные")
  Category.find_or_create_by_name(:name => "Сведения о работе")
  Category.find_or_create_by_name(:name => "Общая информация")
  Category.find_or_create_by_name(:name => "Дополнительная информация")
  Category.find_or_create_by_name(:name => "Вспомогательные элементы")
end