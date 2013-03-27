# encoding: UTF-8

module ValidationSeed
  puts " -- Creating validations"

  Validation.find_or_create_by_name(:name => "Только кириллица, пробелы и тире", :regexp => '/\A([а-яёА-ЯЁ][а-яёА-ЯЁ\s\-]+)*\z/', :default_error_message => "Поле может содержать только кириллицу, пробелы и тире")
  Validation.find_or_create_by_name(:name => "Только кириллица, пробелы, точка и тире", :regexp => '/\A([а-яёА-ЯЁ][а-яёА-ЯЁ\s\.\-]+)*\z/', :default_error_message => "Поле может содержать только кириллицу, пробелы, точки и тире")
  Validation.find_or_create_by_name(:name => "Только цифры, 0 не может быть первым", :regexp => '/\A([1-9][0-9]+)*\z/', :default_error_message => "Поле может содержать только цифры, не может начинаться с нуля")
  Validation.find_or_create_by_name(:name => "Ноль или число не начинающееся с нуля.", :regexp => '/\A(0|([1-9][0-9]+)*)\z/', :default_error_message => "Поле должно содержать ноль или число не начинающееся с нуля")
  Validation.find_or_create_by_name(:name => "Только буквы", :regexp => '/\A[A-Za-zА-Яа-яёЁ]*\z/', :default_error_message => "Поле может содержать только буквы")
  Validation.find_or_create_by_name(:name => "Только цифры", :regexp => '/\A[0-9]*\z/', :default_error_message => "Поле может содержать только цифры")
  Validation.find_or_create_by_name(:name => "Только кириллица", :regexp => '/\A[А-Яа-яёЁ]*\z/', :default_error_message => "Поле может содержать только кириллицу")
  Validation.find_or_create_by_name(:name => "Только латиница", :regexp => '/\A[A-Za-z]*\z/', :default_error_message => "Поле может содержать только латиницу")
  Validation.find_or_create_by_name(:name => "Только латиница заглавные и пробелы", :regexp => '/\A([A-Z][A-Z\s]+)*\z/', :default_error_message => "Поле может содержать только латиницу")
  Validation.find_or_create_by_name(:name => "Только латиница и пробелы", :regexp => '/\A([a-zA-Z][a-zA-Z\s]+)*\z/', :default_error_message => "Поле может содержать только латиницу")
  Validation.find_or_create_by_name(:name => "Только латиница, цифры и точка", :regexp => '/\A([a-zA-Z][a-zA-Z0-9\.]+)*\z/', :default_error_message => "Поле может содержать только латиницу, цифры и точки")
  Validation.find_or_create_by_name(:name => "Только кириллица, латиница,  пробелы, точка и тире", :regexp => '/\A([а-яА-ЯёЁA-Za-z][а-яА-ЯёЁA-Za-z\s\.\-]+)*\z/', :default_error_message => "Поле может содержать только буквы, пробел, точки и тире")
  Validation.find_or_create_by_name(:name => "Только буквы и цифры", :regexp => '/\A([A-Za-zа-яА-ЯёЁ][A-Za-zа-яА-ЯёЁ0-9]+)*\z/', :default_error_message => "Поле может содержать только буквы или цифры")
  Validation.find_or_create_by_name(:name => "Только буквы, пробелы и тире", :regexp => '/\A([а-яА-ЯёЁA-Za-z][а-яА-ЯёЁA-Za-z\s\-]+)*\z/', :default_error_message => "Поле может содержать только буквы, пробел и тире")

  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 2 символа", :regexp => '/\A.{2}\z/', :default_error_message => "Длина поля должна быть ровно 2 символа")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 3 символа", :regexp => '/\A.{3}\z/', :default_error_message => "Длина поля должна быть ровно 3 символа")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 4 символа", :regexp => '/\A.{4}\z/', :default_error_message => "Длина поля должна быть ровно 4 символа")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 5 символов", :regexp => '/\A.{5}\z/', :default_error_message => "Длина поля должна быть ровно 5 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 6 символов", :regexp => '/\A.{6}\z/', :default_error_message => "Длина поля должна быть ровно 6 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 7 символов", :regexp => '/\A.{7}\z/', :default_error_message => "Длина поля должна быть ровно 7 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 8 символов", :regexp => '/\A.{8}\z/', :default_error_message => "Длина поля должна быть ровно 8 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 9 символов", :regexp => '/\A.{9}\z/', :default_error_message => "Длина поля должна быть ровно 9 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 10 символов", :regexp => '/\A.{10}\z/', :default_error_message => "Длина поля должна быть ровно 10 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 11 символов", :regexp => '/\A.{11}\z/', :default_error_message => "Длина поля должна быть ровно 11 символов")
  Validation.find_or_create_by_name(:name => "Совпадение с длиной в 12 символов", :regexp => '/\A.{12}\z/', :default_error_message => "Длина поля должна быть ровно 12 символов")
  Validation.find_or_create_by_name(:name => "Обязательное к заполнению", :regexp => '/\A.+\z/', :default_error_message => "Данное поле обязательно к заполнению")
  Validation.find_or_create_by_name(:name => "Email", :regexp => '/\A[a-zA-Z0-9]+[a-zA-Z0-9\.\_\%\-\+]*[a-zA-Z0-9]+@(?:[a-zA-Z0-9\-]+\.)+[A-Za-z]{2,6}\z/', :default_error_message => "Адрес электронной почты указан неверно")
  Validation.find_or_create_by_name(:name => "Длина более 2 символов", :regexp => '/\A.{2,}\z/', :default_error_message => "Значение должно быть не менее 2 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина более 3 символов", :regexp => '/\A.{3,}\z/', :default_error_message => "Значение должно быть не менее 3 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина более 4 символов", :regexp => '/\A.{4,}\z/', :default_error_message => "Значение должно быть не менее 4 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина более 5 символов", :regexp => '/\A.{5,}\z/', :default_error_message => "Значение должно быть не менее 5 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина менее 4 символов", :regexp => '/\A.{0,4}\z/', :default_error_message => "Значение должно быть не более 4 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина менее 20 символов", :regexp => '/\A.{0,20}\z/', :default_error_message => "Значение должно быть не более 20 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина менее 21 символа", :regexp => '/\A.{0,21}\z/', :default_error_message => "Значение должно быть не более 21 символа длиной")
  Validation.find_or_create_by_name(:name => "Длина более 5 и менее 50 символов", :regexp => '/\A.{5,50}\z/', :default_error_message => "Значение должно быть не более 50 и не менее 5 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина более 5 и менее 60 символов", :regexp => '/\A.{5,60}\z/', :default_error_message => "Значение должно быть не более 60 и не менее 5 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина более 2 и менее 60 символов", :regexp => '/\A.{2,60}\z/', :default_error_message => "Значение должно быть не более 60 и не менее 2 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина более 4 и менее 8 символов", :regexp => '/\A.{4,8}\z/', :default_error_message => "Значение должно быть не более 8 и не менее 4 символов длиной")
  Validation.find_or_create_by_name(:name => "Длина менее 60 символов", :regexp => '/\A.{0,60}\z/', :default_error_message => "Значение должно быть не более 60 символов длиной")
  Validation.find_or_create_by_name(:name => "Номер телефона", :regexp => '/\A((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}\z/', :default_error_message => "Номера телефона указан некорректно")

  Validation.find_or_create_by_name(:name => "Кирилица, латиница, тире, точка, запятая, цифры, наклонная черта", :regexp => '/\A([а-яА-ЯёЁA-Za-z][а-яА-ЯёЁA-Za-z\-\.\,0-9\/]+)*\z/', :default_error_message => "В этом поле допустимы только буквы, тире, точки, запятые, цифры, наклонные черты")
  Validation.find_or_create_by_name(:name => "Кирилица, латиница, тире, точка, запятая, цифры", :regexp => '/\A([а-яА-ЯёЁA-Za-z][а-яА-ЯёЁA-Za-z\-\.\,0-9]+)*\z/', :default_error_message => "В этом поле допустимы только буквы, тире, точки, запятые, цифры")
  Validation.find_or_create_by_name(:name => "Кирилица, латиница, тире, точка, запятая, цифры, пробел", :regexp => '/\A([а-яА-ЯёЁA-Za-z][а-яА-ЯёЁA-Za-z\-\.\,\s0-9]+)*\z/', :default_error_message => "В этом поле допустимы только буквы, тире, точка, запятая, цифры, пробел")
  Validation.find_or_create_by_name(:name => "Кирилица, латиница, тире, точка, цифры, пробел", :regexp => '/\A([а-яА-ЯёЁA-Za-z][а-яА-ЯёЁA-Za-z\-\.\s0-9]+)*\z/', :default_error_message => "В этом поле допустимы только буквы, тире, точки, цифры, пробелы")
  Validation.find_or_create_by_name(:name => "Заглавные буквы и цифры", :regexp => '/\A[А-ЯЁA-Z0-9]*\z/', :default_error_message => "Пожалуйста, введите секректный код, полученный на номер Вашего мобильного телефона")
  Validation.find_or_create_by_name(:name => "Кирилица, тире, точка, запятая, цифры, плюс", :regexp => '/\A([а-яА-ЯёЁ][а-яА-ЯёЁ\-\.\,\+0-9]+)*\z/', :default_error_message => "В этом поле допустимы только кириллица, тире, точки, запятые, цифры, знаки плюса")
  Validation.find_or_create_by_name(:name => "Кирилица, тире, точка, запятая, цифры, наклонная черта", :regexp => '/\A([а-яА-ЯёЁ][а-яА-ЯёЁ\s\-\.\,\/0-9]+)*\z/', :default_error_message => "В этом поле допустимы только кириллица, тире, точки, запятые, цифры, наклонные черты")
  Validation.find_or_create_by_name(:name => "Кирилица, тире, точка, пробел, цифры", :regexp => '/\A([а-яА-ЯёЁ][а-яА-ЯёЁ\s\.\-0-9]+)*\z/', :default_error_message => "В этом поле допустимы только кириллица, тире, точки, пробел, цифры")

  Validation.find_or_create_by_name(:name => "Кем выдан паспорт", :regexp => '/\A([а-яА-ЯёЁ][а-яА-ЯёЁ0-9\№\#\s\-\.]+)\z/', :default_error_message => "Укажите, пожалуйста, кем выдан паспорт")
  Validation.find_or_create_by_name(:name => "test", :regexp => '/^.+$/', :default_error_message => "{F")
  Validation.find_or_create_by_name(:name => "Веб сайт", :regexp => '/\A(www\.([a-zA-Z0-9\.]+)?[a-zA-Z0-9]+\.[a-zA-Z]{2,6})*\z/', :default_error_message => "Укажите, пожалуйста, веб-сайт")
  Validation.find_or_create_by_name(:name => "Латиница, пробелы и точки", :regexp => '/\A([a-zA-Z][a-zA-Z\s\.\-]+)*\z/', :default_error_message => "Поле может содержать только латиницу, пробелы и точки")
  Validation.find_or_create_by_name(:name => "Кирилица, латиница, тире, точка, цифры, пробел для промо-кода", :regexp => '/\A[а-яА-ЯёЁA-Za-z\-\.\s0-9]*\z/', :default_error_message => "В этом поле допустимы только буквы, тире, точки, цифры, пробелы")
  Validation.find_or_create_by_name(:name => "Валидация кода подразделения", :regexp => '/^[0-9]{1}[0-9]{1}[0-9]{1}-[0-9]{1}[0-9]{1}[0-9]{1}$/', :default_error_message => "Укажите, пожалуйста, код подразделения")
  Validation.find_or_create_by_name(:name => "Ноль или число не начинающееся с нуля. Для ежемесячного платежа.", :regexp => '/\A(0|([1-9][0-9]{2,}))\z/', :default_error_message => "Поле должно содержать ноль или число не начинающееся с нуля")
  Validation.find_or_create_by_name(:name => "Ноль или число не начинающееся с нуля. Для суммы кредита.", :regexp => '/\A(0|([1-9][0-9]{3,7}))\z/', :default_error_message => "Поле должно содержать ноль или число не начинающееся с нуля")
end

class Hash
  def to_correct_yaml level=0, from_array=false
    index ||= 0
    "\n" + self.sort{ |p, f| p.first.to_s<=>f.first.to_s}.map{ |key, value|
      index += 1

      [["\s"*level*2, from_array ? index == 1 ? "- " : "  " : "", key].join, value.to_correct_yaml(value.is_a?(Array)&&from_array ? level+2 : level+1)].join(': ')
    }.join("\n")
  end

  def to_stripped_yaml
    self.to_correct_yaml.strip
  end
end

class Array
  def to_correct_yaml level=0
    if self.map(&:class).uniq.first == Hash
      self.map{ |h| h.to_correct_yaml(level-1, true) }.join
    else
      ['[', self.map(&:to_correct_yaml).join(", "), ']'].join
    end
  end
end

class String
  def to_correct_yaml level=0
    ['"', self, '"'].join
  end
end

class TrueClass
  def to_correct_yaml level=0
    self
  end
end

class FalseClass
  def to_correct_yaml level=0
    self
  end
end

class Integer
  def to_correct_yaml level=0
    ['"', self.to_s, '"'].join
  end
end

class Symbol
  def to_correct_yaml level=0
    ['"', self.to_s, '"'].join
  end
end

class Regexp
  def to_correct_yaml level=0
    self.inspect
  end
end

module FieldSeed
  puts " -- Creating fields"
  required = Validation.find_by_name('Обязательное к заполнению')
  validation_1 = Validation.find_by_name('Только кириллица') #Поле может содержать только кириллицу
  validation_2 = Validation.find_by_name('Только кириллица, пробелы и тире') #Поле может содержать только буквы, пробел и тире
  validation_3 = Validation.find_by_name('Только кириллица, пробелы, точка и тире') #Поле может содержать только буквы, пробел, точку и тире
  validation_4 = Validation.find_by_name('Только цифры, 0 не может быть первым') #Поле может содержать только цифры
  validation_5 = Validation.find_by_name('Ноль или число не начинающееся с нуля.') #Ноль или число не начинающееся с нуля
  validation_6 = Validation.find_by_name('Только буквы') #Поле может содержать только буквы
  validation_7 = Validation.find_by_name('Только цифры') #Поле может содержать только буквы
  validation_8 = Validation.find_by_name('Только латиница') #Поле может содержать только латиницу
  valiadtion_9 = Validation.find_by_name('Только латиница заглавные и пробелы') #Поле может содержать только латиницу
  valiadtion_9_1 = Validation.find_by_name('Только латиница и пробелы') #Поле может содержать только латиницу
  validation_10 = Validation.find_by_name('Только латиница, цифры и точка') #Поле может содержать только латиницу, цифры и точку
  validation_11 = Validation.find_by_name('Только кириллица, латиница,  пробелы, точка и тире') #Поле может содержать только буквы, пробел, точку и тире
  validation_12 = Validation.find_by_name('Только буквы и цифры') #Поле может содержать только буквы или цифры
  validation_13 = Validation.find_by_name('Только буквы, пробелы и тире') #Поле может содержать только буквы, пробел и тире
  validation_14 = Validation.find_by_name('Совпадение с длиной в 2 символа') #Длина поля должна быть ровно 2 символа
  validation_15 = Validation.find_by_name('Совпадение с длиной в 3 символа') #Длина поля должна быть ровно 3 символа
  validation_16 = Validation.find_by_name('Совпадение с длиной в 4 символа') #Длина поля должна быть ровно 4 символа
  validation_17 = Validation.find_by_name('Совпадение с длиной в 5 символов') #Длина поля должна быть ровно 5 символа
  validation_18 = Validation.find_by_name('Совпадение с длиной в 6 символов') #Длина поля должна быть ровно 6 символа
  validation_19 = Validation.find_by_name('Совпадение с длиной в 7 символов') #Длина поля должна быть ровно 7 символа
  validation_20 = Validation.find_by_name('Совпадение с длиной в 8 символов') #Длина поля должна быть ровно 8 символа
  validation_21 = Validation.find_by_name('Совпадение с длиной в 9 символов') #Длина поля должна быть ровно 9 символа
  validation_22 = Validation.find_by_name('Совпадение с длиной в 10 символов') #Длина поля должна быть ровно 10 символа
  validation_23 = Validation.find_by_name('Совпадение с длиной в 11 символов') #Длина поля должна быть ровно 11 символа
  validation_24 = Validation.find_by_name('Совпадение с длиной в 12 символов') #Длина поля должна быть ровно 12 символа

  email = Validation.find_by_name('Email') #Адрес электронной почты указан неверно

  validation_25 = Validation.find_by_name('Длина более 2 символов') #Значение должно быть не менее 2 символов длино
  validation_26 = Validation.find_by_name('Длина более 3 символов') #Значение должно быть не менее 2 символов длино
  validation_27 = Validation.find_by_name('Длина более 4 символов') #Значение должно быть не менее 2 символов длино
  validation_28 = Validation.find_by_name('Длина более 5 символов') #Значение должно быть не менее 2 символов длино
  validation_29 = Validation.find_by_name('Длина менее 4 символов') #Значение должно быть не более 4 символов длиной
  validation_30 = Validation.find_by_name('Длина менее 20 символов') #Значение должно быть не более 20 символов длиной
  validation_31 = Validation.find_by_name('Длина менее 21 символов') #Значение должно быть не более 21 символов длиной
  validation_32 = Validation.find_by_name('Длина менее 60 символов') #Значение должно быть не более 60 символов длиной

  validation_33 = Validation.find_by_name('Длина более 5 и менее 50 символов') #Значение должно быть не более 50 символов длиной
  validation_34 = Validation.find_by_name('Длина более 5 и менее 60 символов') #Значение должно быть не более 50 символов длиной
  validation_35 = Validation.find_by_name('Длина более 2 и менее 60 символов') #Значение должно быть не более 50 символов длиной
  validation_36 = Validation.find_by_name('Длина более 4 и менее 8 символов') #Значение должно быть не более 50 символов длиной

  phone = Validation.find_by_name('Номер телефона') #Номера телефона указан некорректно

  #validation for the first form
  validation_37 = Validation.find_by_name('Кирилица, латиница, тире, точка, запятая, цифры, наклонная черта') #Номера телефона указан некорректно
  validation_39 = Validation.find_by_name('Кирилица, латиница, тире, точка, запятая, цифры, пробел') #Номера телефона указан некорректно
  validation_40 = Validation.find_by_name('Кирилица, латиница, тире, точка, запятая, цифры') #Номера телефона указан некорректно
  validation_41 = Validation.find_by_name('Кирилица, латиница, тире, точка, цифры, пробел') #Номера телефона указан некорректно
  validation_42 = Validation.find_by_name('Заглавные буквы и цифры') #Номера телефона указан некорректно
  validation_43 = Validation.find_by_name('Кирилица, тире, точка, запятая, цифры, плюс') #Номера телефона указан некорректно
  validation_44 = Validation.find_by_name('Кирилица, тире, точка, запятая, цифры, косая черта') #Номера телефона указан некорректно

  validation_49 = Validation.find_by_name('Кирилица, тире, точка, пробел, цифры')

  for_passport = Validation.find_by_name('Кем выдан паспорт') #Пожалуйста, укажите, кем выдан паспорт
  # Step 1:
  Field.find_or_create_by_name( :name => "Категория Карты",
                :body => {
                  type: 'item', tag: 'select', label: 'Категория Карты',
                  values: ["MasterCard Standart «Классическая Карта»",
                           "MasterCard Gold «Классическая Карта»",
                           "MasterCard Standart «Наличные»",
                           "MasterCard «Мир Вашей Семьи»"]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Фамилия",
                :body => {
                  type: 'item', tag: 'string', label: 'Фамилия', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_35.id},
                    { id: validation_2.id, message: 'Укажите, пожалуйста, Фамилию, полностью. Язык русский.'}
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Имя",
                :body => {
                  type: 'item', tag: 'string', label: 'Имя', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_35.id},
                    { id: validation_2.id, message: 'Укажите, пожалуйста, Имя, полностью. Язык русский.'}
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Отчество",
                :body => {
                  type: 'item', tag: 'string', label: 'Отчество', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_34.id},
                    { id: validation_2.id, message: 'Укажите, пожалуйста, Отчество, полностью. Язык русский.'}                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Обращение",
                :body => {
                  type: 'item', tag: 'radio', label: 'Обращение', values: ['Господин', 'Госпожа']
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Фамилия латинскими буквами",
                :body => {
                  type: 'item', tag: 'string', label: 'Фамилия как в загранпаспорте', width: 'normal', placeholder: 'Ivanov',
                  validations: [
                    { id: valiadtion_9_1.id },
                    { id: validation_25.id }
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Имя латинскими буквами",
                :body => {
                  type: 'item', tag: 'string', label: 'Имя как в загранпаспорте', width: 'normal', placeholder: 'Ivan',
                  validations: [
                    { id: valiadtion_9_1.id },
                    { id: validation_25.id }
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Дата рождения",
                :body => {
                  type: 'item',
                  tag: 'datepicker',
                  label: "Дата рождения",
                  limit: "1234567890",
                  template: "__.__.____",
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Место рождения",
                :body => {
                  type: 'item', tag: 'radio', label: 'Место рождения',
                  values: ['Россия', 'другое'],
                  scenario: {
                    'Россия' => [
                      {
                          type: 'item', tag: 'string', label: 'Введите место роджения', width: 'normal'
                      }
                    ],
                    'другое' => [
                      {
                        type: 'item', tag: 'string', label: 'Введите место роджения',  width: 'normal',
                        validation: [
                          { id: required.id },
                          { id: validation_41.id }
                        ]
                      }
                    ]
                  }
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  #Field.find_or_create_by_name( :name => "Пароль",
  #              :body => {
  #                type: 'item', tag: 'password', label: 'Пароль',
  #                validations: [
  #                  { message: 'Данное поле обязательно к заполнению', regexp: /^.+$/ }
  #                ]
  #              }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Мобильный телефон",
                :body => {
                  type: 'item', tag: 'string', label: 'Мобильный телефон', width: 'normal', placeholder: '(123) 456-78-90',
                  template: "8 (___) ___-__-__", limit: "1234567890",
                  validations: [
                    { id: required.id },
                    { id: validation_22.id },
                    { id: validation_5.id, message: 'Введите, пожалуйста, номер Вашего мобильного телефона' },
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Откуда Вы узнали о данном предложении?",
                :body => {
                  type: 'item', tag: 'select', label: 'Откуда Вы узнали о данном предложении?',
                  values: ['реклама в Интернете', 'промо-карта', 'мне позвонили', 'мне прислали СМС', 'мне прислали предложение оформить', 'карту прислали по почте', 'прислали письмо по электронной почте', 'от друзей', 'от родственников', 'от знакомых', 'на стойке Банка в магазине', 'в аэропорту', 'в отделении банка']
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Согласие с условиями",
                :body => {
                  type: 'item', tag: 'checkbox', label: 'Я согласен с...',
                  validations: [
                    { message: 'ОАО БИНБАНК не может обработать Вашу анкету без вашего согласия на обработку персональных данных в соответствии со статьей 9 закона №152-ФЗ О персональных данных', regexp: /^true$/ }
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)

  # Step 2:
 Field.find_or_create_by_name( :name => "Адрес (в строку)",
               :body => {
                 type: 'item', tag: 'string', label: 'Адрес', width: 'normal',
                 validations: [
                   { id: required.id },
                   { id: validation_39.id },
                   { id: validation_26.id },
                 ]
               }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Индекс",
                :body => {
                  type: 'item', tag: 'string', label: 'Индекс', width: 'small', placeholder: '111111',
                  limit: '1234567890',
                  validations: [
                    { id: validation_18.id },
                    { id: validation_4.id }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Регион",
                :body => {
                  type: 'item', tag: 'string', label: 'Регион проживания', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_49.id, message: 'Укажите, пожалуйста, Регион' }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Район или город",
                :body => {
                  type: 'item', tag: 'string', label: 'Район или город проживания', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_49.id, message: 'Укажите, пожалуйста, город' }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Населенный пункт",
                :body => {
                  type: 'item', tag: 'string', label: 'Населенный пункт', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_49.id, message: 'Укажите, пожалуйста, населенный пункт' }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Улица",
                :body => {
                  type: 'item', tag: 'string', label: 'Улица', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: validation_26.id },
                    { id: validation_49.id, message: 'Укажите, пожалуйста, Улицу' }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Дом",
                :body => {
                  type: 'item', tag: 'string', label: 'Дом', width: 'tiny',
                  validations: [
                    { id: required.id },
                    { id: validation_29.id },
                    { id: validation_37.id, message: 'Укажите, пожалуйста, номер дома' }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Корпус",
                :body =>  {
                  type: 'item', tag: 'string', label: 'Корпус', width: 'tiny',
                  validations: [
                    { id: validation_37.id, message: 'Укажите, пожалуйста, корпус', regexp: /^([^\-\.\,\/][а-яА-ЯёЁA-Z\-\.\,\/\d]+)?$/ }
                  ]
              }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Строение",
                :body =>  {
                  type: 'item', tag: 'string', label: 'Строение', width: 'tiny',
                  validations: [
                    { id: validation_29.id },
                    { id: validation_37.id, message: 'Укажите, пожалуйста, строение', regexp: /^([^\-\.\,\/][а-яА-ЯёЁA-Z\-\.\,\/\d]+)?$/ }
                 ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Квартира",
                :body => {
                  type: 'item', tag: 'string', label: 'Квартира', width: 'tiny',
                  validations: [
                    { id: required.id },
                    { id: validation_29.id },
                    { id: validation_3.id, message: 'Укажите, пожалуйста, квартиру', regexp: /^([^\-\.\,\/][а-яА-ЯёЁA-Z\-\.\,\/\d]+)?$/ }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Проживаю в частном доме",
                :body =>  {
                  type: 'item', tag: 'checkbox', label: 'Проживаю в частном доме', default_value: false
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "На каком основании Вы проживаете по этому адресу?",
                :body => {
                  type: 'item', tag: 'select', label: 'На каком основании Вы проживаете по этому адресу?',
                  values: ['собственность', 'совместное проживание', 'другое']
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Домашний телефон",
                :body => {
                  type: 'item', tag: 'string', label: 'Домашний телефон', width: 'small', placeholder: '(123) 456-78-90',
                  template: "8 (___) ___-__-__", limit: "1234567890",
                  validations: [
                    { id: required.id },
                    { id: validation_22.id },
                    { id: validation_7.id, message: 'Номер телефона указан некорректно' }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Контактный e-mail",
                :body => {
                  type: 'item', tag: 'string', label: 'Контактный e-mail', width: 'normal', placeholder: 'example@example.com',
                  validations: [
                    { id: email.id },
                    { id: validation_33.id }
                  ]
                }.to_stripped_yaml, :category_id => 2, :organization_id => 1)

  # Step 2.1:
  Field.find_or_create_by_name( :name => "Серия",
                :body => {
                  type: 'item', tag: 'string', label: 'Серия', width: 'tiny', placeholder: '1111',
                  limit: '1234567890',
                  validations: [
                    { id: required.id },
                    { id: validation_16.id },
                    { id: validation_4.id, message: 'Пожалуйста, введите серию паспорта' }
                  ]
                }.to_stripped_yaml, :category_id => 3, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Номер",
                :body => {
                  type: 'item', tag: 'string', label: 'Номер', width: 'small', placeholder: '111111',
                  limit: '1234567890',
                  validations: [
                    { id: required.id },
                    { id: validation_18.id },
                    { id: validation_4.id, message: 'Пожалуйста, введите номер паспорта' }
                  ]
              }.to_stripped_yaml, :category_id => 3, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Дата выдачи",
                :body => {
                  type: 'item',
                  tag: 'datepicker',
                  label: "Дата выдачи",
                  limit: "1234567890",
                  template: "__.__.____",
                }.to_stripped_yaml, :category_id => 3, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Кем выдан",
                :body => {
                  type: 'item', tag: 'textarea', label: 'Кем выдан паспорт', height: 'tiny', placeholder: 'ОВД №100',
                  validations: [
                    { id: required.id },
                    { id: for_passport.id, message: 'Укажите, пожалуйста, кем выдан паспорт' },
                    { id: validation_28.id }
                  ]
                }.to_stripped_yaml, :category_id => 3, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Код подразделения",
                :body => {
                  type: 'item', tag: 'string', label: 'Код подразделения', width: 'small', placeholder: '111-222',
                  template: "___-___",
                  limit: '1234567890',
                  validations: [
                    { id: required.id },
                    { id: validation_18.id },
                    { id: validation_7.id, message: 'Укажите, пожалуйста, код подразделения' }
                  ]
                }.to_stripped_yaml, :category_id => 3, :organization_id => 1)

  # Step 3:
  Field.find_or_create_by_name( :name => "Информация о работе",
                :body => {
                  type: 'item', tag: 'radio', label: 'Работаете ли Вы?',
                  values: ['Да', 'Нет'],
                  scenario: {
                    'Нет' => [
                        #TWO DROPBOXES
                        { type: 'group', header: 'С какого времени Вы не работаете',
                          items: [
                            { type: 'item', tag: 'select', label: 'Месяц',
                              values: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
                            },
                            {
                              type: 'item', tag: 'select', label: 'Год',
                              values: ["1900", "1901", "1902", "1903", "1904", "1905", "1906", "1907", "1908", "1909", "1910", "1911", "1912", "1913", "1914", "1915", "1916", "1917", "1918", "1919", "1920", "1921", "1922", "1923", "1924", "1925", "1926", "1927", "1928", "1929", "1930", "1931", "1932", "1933", "1934", "1935", "1936", "1937", "1938", "1939", "1940", "1941", "1942", "1943", "1944", "1945", "1946", "1947", "1948", "1949", "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999"],
                              default_value: '1'
                            }
                          ]
                        },
                        { type: 'item', tag: 'select', label: 'В настоящее время являюсь',
                          values: ['пенсионером', 'нахожусь в отпуске по уходу за ребенком','студентом','другое']
                        },
                        { type: 'item', tag: 'select', label: 'Источник средств',
                          values: ['накопления', 'нахожусь на попечении', 'социальные выплаты/пособия','другое'],
                        }

                    ],
                    'Да' => [
                      { type: 'item', tag: 'string', label: 'Название организации', placeholder: 'ООО Компания', width: 'large',
                        validations: [
                          { id: required.id },
                          { id: validation_28.id, message: 'Пожалуйста, укажите Название организации' }
                        ]
                      },

                      { type: 'item', tag: 'select',  label: 'В какой сфере работает Ваша организация?',
                        values: ['Банковское дело/Финансовые услуги', 'Гостиничный бизнес', 'Государственная служба', 'Добывающая промышленность', 'Здравоохранение', 'Информационные технологии', 'Культура/Религия', 'Легкая и пищевая промышленность', 'Лесное/Сельское хозяйство', 'Машиностроение', 'Металлургия', 'Наука', 'Образование', 'Общественное питание', 'Правоохранительная деятельность', 'Производство стройматериалов', 'Реклама/PR', 'Риэлторская деятельность', 'Складские услуги', 'Средства массовой информации', 'Страхование', 'Строительство', 'Телекоммуникации и Связь', 'Топливно-Энергетический Комплекс', 'Торговля', 'Транспорт/Логистика', 'Физическая культура/Спорт', 'Юридические услуги', 'другое']
                      },

                      { type: 'item', tag: 'select', label: 'С какого времени Вы в этой организации - месяц',
                        values: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
                      },
                      {
                          type: 'item', tag: 'select', label: 'С какого времени Вы в этой организации - год',
                          values: ["1900", "1901", "1902", "1903", "1904", "1905", "1906", "1907", "1908", "1909", "1910", "1911", "1912", "1913", "1914", "1915", "1916", "1917", "1918", "1919", "1920", "1921", "1922", "1923", "1924", "1925", "1926", "1927", "1928", "1929", "1930", "1931", "1932", "1933", "1934", "1935", "1936", "1937", "1938", "1939", "1940", "1941", "1942", "1943", "1944", "1945", "1946", "1947", "1948", "1949", "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999"],
                          default_value: '1'
                      },
                      { type: 'item', tag: 'select', label: 'С какого времени Вы начали трудовую деятельность - месяц',
                        values: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
                      },
                      {  type: 'item', tag: 'select', label: 'С какого времени Вы начали трудовую деятельность - год',
                         values: ['1900', '1901', "1902", "1903", "1904", "1905", "1906", "1907", "1908", "1909", "1910", "1911", "1912", "1913", "1914", "1915", "1916", "1917", "1918", "1919", "1920", "1921", "1922", "1923", "1924", "1925", "1926", "1927", "1928", "1929", "1930", "1931", "1932", "1933", "1934", "1935", "1936", "1937", "1938", "1939", "1940", "1941", "1942", "1943", "1944", "1945", "1946", "1947", "1948", "1949", "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999"],
                         default_value: '1'
                      },
                      { type: 'item', type: 'item', tag: 'string', label: 'Какую должность Вы занимаете?', width: 'large',
                        validations: [
                          { id: required.id }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Веб-сайт Вашей организации', width: 'normal', placeholder: 'http://www.example.com',
                        validations: [
                          { id: validation_10.id}
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Индекс', width: 'small', placeholder: '111111', limit: '1234567890',
                        validations: [
                          { id: validation_18.id },
                          { id: validation_4.id }
                        ]
                      },
                      { tag: 'string', label: 'Регион', width: 'large', type: 'item',
                        validations: [
                          { id: required.id },
                          { id: validation_49.id, message: 'Укажите, пожалуйста, Регион' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Район или город', width: 'normal',
                        validations: [
                          { id: required.id },
                          { id: validation_49.id, message: 'Укажите, пожалуйста, город' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Населенный пункт', width: 'normal',
                        validations: [
                          { id: required.id },
                          { id: validation_49.id, message: 'Укажите, пожалуйста, населенный пункт' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Улица', width: 'large',
                        validations: [
                          { id: required.id },
                          { id: validation_26.id },
                          { id: validation_49.id, message: 'Укажите, пожалуйста, Улицу' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Дом', width: 'tiny',
                        validations: [
                          { id: required.id },
                          { id: validation_29.id },
                          { id: validation_37.id, message: 'Укажите, пожалуйста, Дом' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Корпус', width: 'tiny',
                        validations: [
                          { id: validation_29.id },
                          { id: validation_37.id, message: 'Укажите, пожалуйста, Корпус' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Строение', width: 'tiny',
                        validations: [
                          { id: validation_29.id },
                          { id: validation_37.id, message: 'Укажите, пожалуйста, Строение' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Офис', width: 'tiny',
                        validations: [
                          { id: validation_29.id },
                          { id: validation_49.id, message: 'Укажите, пожалуйста, Офис' }
                        ]
                      },
                      { type: 'item', tag: 'string', label: 'Телефон организации', width: 'normal', placeholder: '(123) 456-78-90',
                        template: "8 (___) ___-__-__", limit: "1234567890",
                        validations: [
                          { id: validation_22.id },
                          { id: validation_7.id, message: 'Введите, пожалуйста номер телефона' }
                        ]
                      }
                    ]
                  }
                }.to_stripped_yaml, :category_id => 4, :organization_id => 1)

  # Step 4
  Field.find_or_create_by_name( :name => "Есть ли у Вас загранпаспорт?",
                :body => {
                  type: 'item', tag: 'select', label: 'Есть ли у Вас загранпаспорт?',
                  values: ['Да', 'Нет']
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Семейное положение",
                :body => {
                  type: 'item', tag: 'select', label: 'Семейное положение',
                  values: ['женат/замужем', 'в разводе', 'холост/не замужем', 'вдова/вдовец', 'другое']
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Образование",
                :body => {
                  type: 'item', tag: 'select', label: 'Образование',
                  values: ['среднее', 'среднее специальное', 'незаконченное высшее', 'высшее', 'ученая степень или несколько высших', 'другое']
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Есть ли у Вас недвижимость в собственности?",
                :body => {
                  type: 'item', tag: 'select', label: 'Есть ли у Вас недвижимость в собственности?',
                  values: ['Да', 'Нет']
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Каков Ваш среднемесячный доход?",
                :body => {
                  type: 'item', tag: 'string', label: 'Укажите, пожалуйста Ваш доход', width: 'normal',
                  hint: { style: 'block',text: 'В рублях.' },
                  limit: '1234567890',
                  validations: [
                    { id: required.id },
                    { id: validation_26.id },
                    { id: validation_7.id, message: 'Укажите, пожалуйста, Ваш доход' }
                  ]
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Сколько рублей в месяц Вы платите в погашение кредитов?",
                :body => {
                  type: 'item', tag: 'string', label: 'Сколько рублей в месяц Вы платите в погашение кредитов?', width: 'normal',  hint: { style: 'block',   text: 'Если у Вас нет кредитов, введите цифру 0 в поле' },
                  limit: '1234567890',
                  validations: [
                    { id: required.id },
                    { id: validation_5.id },
                    { id: validation_26.id },
                    { id: validation_7.id, message: 'Укажите, пожалуйста, Ваш доход' }
                  ]
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Общая сумма последнего кредита.",
                  :body => {
                    type: 'item', tag: 'string', label: 'Общая сумма последнего кредита.', width: 'normal',
                    hint: { style: 'block',   text: 'Если у Вас нет кредитов, введите цифру 0 в поле' }, limit: '1234567890',
                    validations: [
                    { id: required.id },
                    { id: validation_5.id },
                    { id: validation_36.id },
                    { id: validation_7.id, message: 'Укажите, пожалуйста, Ваш доход' }
                    ]
                  }.to_stripped_yaml, :category_id => 5, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Тип последнего кредита",
                :body => {
                  type: 'item', tag: 'select', label: 'Тип последнего кредита',
                  values: [
                    'Не было кредитов', 'Кредит на автомобиль', 'Потребительский кредит',
                    'Кредитная карта', 'Ипотека', 'Кредит на развитие бизнеса', 'Кредит на пополнение оборотных средств',
                    'Лизинг', 'Кредит на строительство недвижимости', 'Кредит на покупку акций', 'Кредит на покупку оборудования', 'Другое'
                  ]
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)


  Field.find_or_create_by_name( :name => "Сколько в месяц Вы тратите на жизнь?",
                :body => {
                  type: 'item', tag: 'string', label: 'Сколько в месяц Вы тратите на жизнь?', width: 'normal', limit: '1234567890',
                  validations: [
                    { id: required.id },
                    { id: validation_26.id },
                    { id: validation_7.id, message: 'Пожалуйста, укажите сумму цифрами' }
                  ]
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Вы являетесь клиентом банка?",
                :body =>  {
                  type: 'item', tag: 'select', label: 'Вы являетесь клиентом банка?',
                  values: ['Да', 'Нет']
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Является ли Вы клиентом БИНБАНКа?",
                :body => {
                  type: 'item', tag: 'radio', label: 'Является ли Вы клиентом БИНБАНКа?',
                  values: ['Да', 'Нет'],
                  scenario: {
                    'Да' => [
                      {
                        type: 'item', tag: 'radio', label: 'Есть ли у Вас депозит в БИНБАНКе или в другом банке?',
                        values: ['Да', 'Нет']
                      }
                    ],
                    'Нет' => [
                      {
                        type: 'item', tag: 'radio', label: 'Если ли у Вас депозит в другом банке?',
                        values: ['Да', 'Нет']
                      }
                    ]
                  }
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Есть ли у Вас дети?",
                :body => {
                  type: 'item', tag: 'radio', label: 'Есть ли у Вас дети?',
                  values: ['Да', 'Нет'],
                  scenario: {
                    'Есть' => [
                      {
                        type: 'item', tag: 'select', label: 'Сколько у Вас детей?',
                        values: ["1", "2", "3", "4", "5", "больше"]
                      }
                    ],
                    'Нет' => []
                  }
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Есть ли у Вас автомобиль?",
                :body => {
                  type: 'item', tag: 'radio', label: 'Есть ли у Вас автомобиль?',
                  values: ['Да', 'Нет']
                }.to_stripped_yaml, :category_id => 5, :organization_id => 1)

  Field.find_or_create_by_name( :name => "СМС-Информирование ",
                  :body => {
                    type: 'item', tag: 'radio', label: "Прошу подключить на мобильный телефон, указанный в пункте 'контактная информация' настоящего заявления СМС-информирование по запросу и о каждой операции по карте (Абонентская плата за СМС-информирование об операциях по карте - 50 руб/мес.)",
                    values: ['Да', 'Нет'],
                    hint: {
                      style: 'block',
                      text: 'Абонентская плата за СМС-информирование об операциях по карте - 50 руб/мес'
                    }
                  }.to_stripped_yaml, :category_id => 5, :organization_id => 1)


  # Step 5
  Field.find_or_create_by_name( :name => "Выберите способ получения кредитной карты",
                :body => {
                  type: 'item', tag: 'select', label: 'Выберите способ получения кредитной карты',
                  values: ['Обычное письмо почтой России', 'Заказное письмо почтой России', 'Доставка через отделение банка','Курьерская доставка'],
                  default_value: '1',
                }.to_stripped_yaml, :category_id => 6, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Совпадает с адресом проживания",
                :body => {
                  type: 'item', tag: 'checkbox', label: 'Совпадает с адресом проживания',
                }.to_stripped_yaml, :category_id => 6, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Выберите Регион доставки Карты",
                :body => {
                  type: 'item', tag: 'select', label: 'Выберите Регион доставки Карты',
                  values: ["Агинское", "Барнаул", "Владимир", "Волгоград", "Екатеринбург", "Иваново", "Ижевск", "Иркутск", "Йошкар-Ола", "Казань", "Калининград", "Кострома", "Краснодар", "Москва", "Нижний Новгород", "Новосибирск", "Омск", "Оренбург", "Орехово-Зуево", "Пенза", "Пермь", "Ростов-на Дону", "Самара", "Санкт-Петербург", "Саранск", "Саратов", "Ставрополь", "Томск", "Тюмень", "Улан-Удэ", "Ульяновск", "Чебоксары", "Челябинск", "Ярославль"],
                  scenario: {
                    'Ярославль' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["150003, г. Ярославль, ул. Республиканская, д. 12/2", "150000, г. Ярославль, ул. Свободы, д.2", "150030, г. Ярославль, Московский проспект, д. 93"]
                      }
                    ],
                    'Саранск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["430000, Республика Мордовия, г. Саранск, Ленинский р-н, ул. Большевистская, д. 60"]
                      }
                    ],
                    'Оренбург' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["460024, г. Оренбург, улица Чкалова, д.2"]
                      }
                    ],
                    'Омск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["644010, г. Омск, пл. Ленинградская, д.1", "644024, г. Омск, ул. Лермонтова, д. 20", "644053, г. Омск, ул. Нефтезаводская, д.17"]
                      }
                    ],
                    'Йошкар-Ола' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["424031, Республика Марий Эл, г. Йошкар-Ола, ул. Машиностроителей, д.9", "424000, Республика Марий Эл, г. Йошкар-Ола, Ленинский пр-т, д. 47", "424000, Республика Марий Эл, г. Йошкар-Ола, улица Советская, д. 154"]
                      }
                    ],
                    'Улан-Удэ' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["670000, Республика Бурятия, г. Улан-Удэ, ул. Коммунистическая, д.20", "670042, Республика Бурятия, г. Улан-Удэ, проспект Строителей, д.12, кв.3"]
                      }
                    ],
                    'Тюмень' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["625048, г. Тюмень, ул. Фабричная, д. 5/1."]
                      }
                    ],
                    'Саратов' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["410600, г. Саратов, ул. им. Шевченко Т.Г., д. 18", "410052, г. Саратов, ул. Одесская, д.2", "Саратовская область, 413100, г. Энгельс, ул. Тельмана, д.14"]
                      }
                    ],
                    'Пермь' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["614000 г. Пермь, ул. Газеты Звезда, д.27", "618419, Пермский край, г. Березники, ул.Ломоносова, д.92", "614113, Пермский край, г. Пермь, ул. Автозаводская, д.44", "614039, Пермский край, г. Пермь, ул. Сибирская, д. 63"]
                      }
                    ],
                    'Калининград' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["236016, г. Калининград, пл. Василевского, д.2", "236039, г. Калининград, Ленинский проспект, д. 95/101", "238750, Калининградская обл., г. Советск, ул. Победы, д. 45", "238150, Калининградская область, г.Черняховск, ул.Ленина, д.16", "236016, г. Калининград, пл. Василевского, д.2", "238210, Калининградская область, г. Гвардейск, пл. Победы, д.1\320\260"]
                      }
                    ],
                    'Иркутск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["664054, Иркутская обл., г. Иркутск, ул. Лермонтова, д.257"]
                      }
                    ],
                    'Иваново' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["153012, г. Иваново, ул. Советская, д.22"]
                      }
                    ],
                    'Волгоград' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["400131, г. Волгоград, пр-т им. В.И. Ленина, д.10", "404120, Волгоградская область, г.Волжский, проспект Ленина, д.75", "400048, г. Волгоград, проспект им. Маршала Советского Союза Г.К. Жукова, д.161", "400112, г. Волгоград, проспект Героев Сталинграда, д.48"]
                      }
                    ],
                    'Самара' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["443099, г. Самара, ул.Фрунзе, д. 100, угол ул. Некрасовская, д. 27", "443001, г. Самара ул. Полевая, д. 65", "445030, Самарская обл., г. Тольятти, ул. Тополиная, д.45", "443045, г.Самара, ул. Авроры, д.181"]
                      }
                    ],
                    'Новосибирск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["630102, г. Новосибирск, ул. Нижегородская, д. 4", "630091, г. Новосибирск, Красный Проспект, д.59.", "630064, г. Новосибирск, ул. Ватутина, д.33", "630099 , г. Новосибирск, Вокзальная магистраль, д.13", "630111, г. Новосибирск, ул. Ипподромская, д.44.", "630007, г. Новосибирск, Красный проспект, д.24"]
                      }
                    ],
                    'Нижний Новгород' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["603000, г. Нижний Новгород, ул. Звездинка, д. 18", "603002, г. Нижний Новгород, ул. Советская,12", "603138, г.Нижний Новгород, ул. Героя Плотникова, д.3", "607060, Нижегородская область, г. Выкса, ул. Красные Зори, д.5, помещение 50"]
                      }
                    ],
                    'Москва' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["129164, г. Москва, Зубарев пер., д. 15, кор. 1", "105066, г. Москва, ул. Спартаковская, д.6, стр. 1", "103064, г. Москва, Земляной Вал, д. 34, стр. 3\320\220", "115563, г. Москва, Каширское шоссе, д. 61, корп. 3\320\260", "123022, г. Москва, ул. Красная Пресня, д.23, корп. Б стр.1", "107140, г. Москва, ул.Краснопрудная, д.7-9", "121248, г. Москва Кутузовский пр-т, д.8", "119071, г. Москва, Ленинский пр-т, д. 20", "125047, г. Москва, ул. 1-я Тверская-Ямская, д.8", "121471, г. Москва, Можайское ш., д. 11", "115054, г. Москва, ул. Зацепский Вал., д. 5", "129010, г. Москва, Проспект Мира, 42 стр. 1", "115184, г. Москва, ул. Пятницкая, д.47, стр.1", "121615, г. Москва, Рублевское ш., д. 22, корп. 1", "127015, г. Москва, ул. Бутырская, д. 4", "109004, г. Москва, ул. Верхняя Радищевская, д.13,стр.3-3\320\260", "125047, г. Москва ул. 1-ая Тверская-Ямская, д. 18", "125057, г. Москва, Ленинградский пр-т, д. 75, корп. 1Б ", "121059, г. Москва, Пл. Европы., д. 2", "125009, г. Москва, ул. Тверская, д. 26/1, комната 79", "125047, г. Москва, ул. 1-я Тверская-Ямская, д. 34.", "125047 г. Москва, ул. Лесная, д.15", "141508, Московская область, г. Солнечногорск, микрорайон Рекинцо, д.14", "129272 г. Москва, ул. Сущевский Вал, д.74", "115191, г. Москва, ул. Большая Тульская, д.11", "109004, г. Москва, Известковый переулок, д.3.", "107078 ,   г. Москва, ул. Каланчевская, д.21/40"]
                      }
                    ],
                    'Кострома' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["156000, г. Кострома, ул. Советская, д. 92", "156013, г. Кострома, ул. Ленина, д.45"]
                      }
                    ],
                    'Чебоксары' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["428015, Чувашская Республика, г. Чебоксары, Московский проспект, д. 21, корпус 2"]
                      }
                    ],
                    'Ульяновск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["432063, г. Ульяновск, ул. Матросова, д. 33", "433500, Ульяновская область, г. Димитровград, пр-т Димитрова, д. 2", "432072, г. Ульяновск, проспект Ульяновский, д.1", "432045, г. Ульяновск, ул. Станкостроителей, д. 24", "432063, г.Ульяновск, ул. Гончарова. д.36", "432054, г.Ульяновск, ул.Камышинская, д.49.", "432072, г. Ульяновск, проспект Ленинского Комсомола, д.37", "432063, г. Ульяновск, ул. Гончарова, д. 27."]
                      }
                    ],
                    'Краснодар' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["350000, Российская Федерация, Краснодарский край, г. Краснодар, Западный внутригородской округ, ул. Рашпилевская, дом № 36/2", "350075, Краснодарский край, г. Краснодар, ул. Селезнева, д. 110"]
                      }
                    ],
                    'Казань' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["420111, Республика Татарстан, г. Казань, ул. Лево-Булачная, д. 24/20"]
                      }
                    ],
                    'Екатеринбург' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["620027, г. Екатеринбург, ул. Свердлова, д. 11\320\260", "620014, г. Екатеринбург, ул. Малышева, д. 17 \320\260", "622036, Свердловская область, г.Нижний Тагил, проспект Мира, д.33.", "620062, г. Екатеринбург, проспект Ленина, д.99", "620102, г.Екатеринбург, ул. Шаумяна, д.103, корпус 1", "620098, г. Екатеринбург, проспект Космонавтов, д.47"]
                      }
                    ],
                    'Ставрополь' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["355017, г. Ставрополь, ул. Ленина, д. 221", "355042, Ставропольский край, г. Ставрополь, ул. Доваторцев, д.61", "357519, Ставропольский край, г.Пятигорск, пр.40-летия Октября, д.23 ", "355000 , Ставропольский край, г. Ставрополь, площадь Ленина, д.3"]
                      }
                    ],
                    'Ижевск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["426008, Удмуртская Республика, г. Ижевск, ул. Пушкинская, д. 245 \320\260", "426057, Удмуртская Республика, г. Ижевск, ул. Советская, д. 10"]
                      }
                    ],
                    'Барнаул' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["656015, г. Барнаул, проспект Социалистический, д.130"]
                      }
                    ],
                    'Санкт-Петербург' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["196070, г. Санкт-Петербург, Московский пр-т, д. 173, пом. 3Н, литера \320\220", "191186, г. Санкт-Петербург, Невский проспект, дом 22-24, помещение 66Н, литера А.  ", "199004, г. Санкт-Петербург, 9-я линия В.О., д.34, литер \320\220", "191101, г. Санкт-Петербург, Каменноостровский пр., дом 20, лит. А, пом. 1\320\235", "191036, г. Санкт-Петербург, Невский проспект, дом 134, литера Б. ", "190031, г. Санкт-Петербург, Садовая ул., д.44, литера \320\220", "194356, г. Санкт-Петербург, пр. Луначарского, д.54, литер А, пом. 3\320\235", "197341, г. Санкт-Петербург, Коломяжский проспект, д.26, помещение 36Н, литер А."]
                      }
                    ],
                    'Агинское' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["687000, Забайкальский край, Агинский Бурятский округ, пгт. Агинское, ул. Комсомольская, д.3", "672010, Забайкальский край, г.Чита, Ингондинский административный район, ул.Ингондинская, д.6"]
                      }
                    ],
                    'Томск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["634034, г. Томск, Кирова проспект, д. 3\320\221"]
                      }
                    ],
                    'Ростов-на Дону' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["344019, г. Ростов-на-Дону, проспект Шолохова, д.32/65", "344002, г. Ростов-на-Дону, Буденновский проспект, д. 55", "344103, г.Ростов-на-Дону, ул.339-й Стрелковой Дивизии, д.5/60 \320\261", "346400, Ростовская область, г. Новочеркасск, ул. Дубовского, д. 28", "344022, г. Ростов-на-Дону, пер. Журавлева, д.63", "344092, г. Ростов-на-Дону, ул. Волкова, д. 10, литер \320\220", "347382, Ростовская область, г. Волгодонск, ул. Энтузиастов, д. 14\320\260"]
                      }
                    ],
                    'Орехово-Зуево' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["142600, г. Орехово-Зуево, Центральный б-р, д. 3", "143914, Московская область, г. Балашиха, Микрорайон ЦОВБ, д.20, II\320\261"]
                      }
                    ],
                    'Челябинск' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["454114, г. Челябинск, ул. Кирова, д. 7-\320\260", "454091, г. Челябинск, ул. Свободы, д.161", "456300, Челябинская область, г.Миасс, проспект Автозаводцев, д.15", "455000, Челябинская область, г. Магнитогорск, пр. К.Маркса, д.49"]
                      }
                    ],
                    'Пенза' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["440000, г. Пенза, Московская ул., д. 3"]
                      }
                    ],
                    'Владимир' => [
                      {
                        type: 'item', tag: 'select', label: 'Выберите отделение для доставки',
                        values: ["600022, г. Владимир, проспект Ленина, д.48"]
                      }
                    ]
                  }
                }.to_stripped_yaml, :category_id => 6, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Код проверки мобильного телефона",
                :body => {
                  type: 'item', tag: 'string', label: 'Код проверки мобильного телефона', width: 'normal',
                  validations: [
                    { id: validation_42.id, message: 'Пожалуйста, введите секректный код, полученный на номер Вашего мобильного телефона' }
                  ]
                }.to_stripped_yaml, :category_id => 6, :organization_id => 1)


  Field.find_or_create_by_name( :name => "Год",
                :body => {
                  type: 'item', tag: 'select', label: 'Год',
                  values: ["1900", "1901", "1902", "1903", "1904", "1905", "1906", "1907", "1908", "1909", "1910", "1911", "1912", "1913", "1914", "1915", "1916", "1917", "1918", "1919", "1920", "1921", "1922", "1923", "1924", "1925", "1926", "1927", "1928", "1929", "1930", "1931", "1932", "1933", "1934", "1935", "1936", "1937", "1938", "1939", "1940", "1941", "1942", "1943", "1944", "1945", "1946", "1947", "1948", "1949", "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999"],
                  default_value: '1'
                }.to_stripped_yaml, :category_id => 7, :organization_id => 1)

  Field.find_or_create_by_name( :name => "Meсяц",
                :body => {
                  type: 'item', tag: 'select', label: 'Meсяц',
                  values: ["январь", "февраль", "март", "апрель", "май", "июнь", "июль", "август", "сентябрь", "октябрь", "ноябрь", "декабрь"],
                  default_value: '1'
                }.to_stripped_yaml, :category_id => 7, :organization_id => 1)

  Field.find_or_create_by_name( :name => "День",
                :body => {
                  type: 'item', tag: 'select', label: 'День',
                  values: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"],
                  default_value: '1'
                }.to_stripped_yaml, :category_id => 7, :organization_id => 1)

  # Additional
  Field.find_or_create_by_name( :name => "Email",
                :body => {
                  type: 'item', tag: 'string', label: 'Email', width: 'normal',
                  validations: [
                    { id: required.id },
                    { id: email.id }
                  ]
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Пол:",
                :body => {
                  type: 'item', tag: 'radio', label: 'Укажите Ваш пол:',
                  values: ['Мужчина', 'Женщина']
                }.to_stripped_yaml, :category_id => 1, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Разделитель",
                :body => {
                  type: 'item', tag: 'separator'
                }.to_stripped_yaml, :category_id => 7, :organization_id => 1)
  Field.find_or_create_by_name( :name => "Вce поля обязательны к заполнению!",
                :body => {
                  type: 'item', tag: 'announce', text: 'Все поля обязательны к заполнению!'
                }.to_stripped_yaml, :category_id => 7, :organization_id => 1)
end
