puts "reindex #{Item.count} items"
items_index = IndexFactory.new.items
pp items_index.destroy
pp items_index.create
items_index.import_in_batches Item
puts "search"

def search(params = {})

  puts "Search: #{params.inspect}"
  items_search = SearchFactory.new.items
  items = items_search.search(params).items

  puts "\nResult items:"
  items.each do |i|
    puts "\n  Item id: #{i.id}, score: #{i._score}"
    d = Item.find i.id
    puts d.description
  end

  puts "\n"
end

sleep 3

search
search q: "qwery"
search q: "null"
search q: "ruby on rails"
search q: "rails"
