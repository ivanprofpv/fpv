class SearchService
  def initialize(query)
    @query = ThinkingSphinx::Query.escape(query)
  end

  def call
    @query.empty? ? [] : ThinkingSphinx.search(@query, order: 'created_at DESC')
  end
end
