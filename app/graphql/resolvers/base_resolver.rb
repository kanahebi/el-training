module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def pagination(result)
      {
        total_count: result.total_count,
        limit_value: result.limit_value,
        total_pages: result.total_pages,
        current_page: result.current_page,
        next_page: result.next_page,
        prev_page: result.prev_page,
        is_first_page: result.first_page?,
        is_last_page: result.last_page?
      }
    end
  end
end
