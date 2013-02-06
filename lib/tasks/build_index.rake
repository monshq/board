
namespace :elastic do

  desc "Reindex elastic db"
  task reindex: :environment do
    Item.index.import Item.all
  end

end
