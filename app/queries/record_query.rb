# frozen_string_literal: true

class RecordQuery
  DEFAULT_SORT_BY = :updated_at
  DEFAULT_SORT_DIRECTION = :desc

  def initialize(scope, filter_params: {}, search_param: nil,
                 sort_by: DEFAULT_SORT_BY,
                 sort_direction: DEFAULT_SORT_DIRECTION)
    @scope = scope
    @filter_params = filter_params.compact_blank!
    @search_param = search_param
    @sort_by = sort_by
    @sort_direction = sort_direction
  end

  def call
    filter if filter_params.any?
    search if search_param.present?
    order if search_param.present?

    scope
  end

  private

  attr_reader :filter_params, :scope, :search_param

  def filter
    @scope = scope.where(options)
  end

  def search
    return unless scope.respond_to?(:search)

    @scope = scope.search(scope.sanitize_sql_like(search_param))
  end
end
