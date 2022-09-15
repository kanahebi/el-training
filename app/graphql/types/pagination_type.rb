module Types
  class PaginationType < Types::BaseObject
    field :total_count, Int, null: true
    field :limit_value, Int, null: true
    field :total_pages, Int, null: true
    field :current_page, Int, null: true
    field :next_page, Int, null: true
    field :prev_page, Int, null: true
    field :is_first_page, Boolean, null: true
    field :is_last_page, Boolean, null: true
  end
end
