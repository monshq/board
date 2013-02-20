
namespace :elastic do

  desc "Reindex elastic db"
  task reindex: :environment do
    ElasticSearch::Factories::IndexFactory.items.import Item.all
  end

end
