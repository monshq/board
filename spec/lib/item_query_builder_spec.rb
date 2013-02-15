# encoding: UTF-8

require 'spec_helper'

describe ElasticSearch::QueryBuilders::ItemQueryBuilder do
  before(:all) do
    @query_builder_class = ElasticSearch::QueryBuilders::ItemQueryBuilder
    @item_mapping_class = ElasticSearch::Mappings::ItemMapping
  end

  describe 'to_proc' do
    it 'Возвращает proc' do
      qb = @query_builder_class.new({}, @item_mapping_class.new)
      qb.to_proc.should be_a_kind_of(Proc)
    end
  end

end
