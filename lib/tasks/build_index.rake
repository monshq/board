
namespace :elastic do

  desc "Reindex elastic db"
  task reindex: :environment do
    Item.elastic_index.import_in_batches Item.published
  end

end
