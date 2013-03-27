module FormGenerator
  module ApplicationHelper
    def date_in_russian datetime
      datetime.strftime("%d.%m.%Y") + " " + datetime.strftime("%H:%M")
    end
  end
end