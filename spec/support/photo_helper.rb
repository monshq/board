# encoding: UTF-8

def add_photo(item)
  @photo = FactoryGirl.create(:photo, item: item)
end
