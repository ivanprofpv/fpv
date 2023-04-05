ThinkingSphinx::Index.define :drone, with: :active_record do
  indexes title, sortable: true

  has user_id, created_at, updated_at
end
