
namespace :elastic do

  desc "Reindex elastic db"
  task reindex: :environment do
    IndexFactory.items.import_in_batches Item.published
  end

end
