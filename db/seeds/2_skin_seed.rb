# encoding: UTF-8

module SkinSeed
  puts " -- Creating skins"
  Skin.find_or_create_by_title(:title => "Стандартный", :body => "{\"colors\": {\"header\": \"#000\",\"label\": \"#000\",\"hint\": \"#aaa\",\"error\": \"#f33\",\"link\": \"#006dca\",\"link_hover\": \"#006dca\",\"separator\": \"#c1d7ea\"},\"fonts\": {\"header\": \"Lucida Grande\",\"form\": \"Lucida Grande\"}}", :organization_id => 1, :builder_id => 1)
end