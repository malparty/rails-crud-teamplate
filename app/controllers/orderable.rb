# frozen_string_literal: true

module Orderable
  extend ActiveSupport::Concern


  protected

  def ordered(scope)
    if scope.column_names.include?(order_by.to_s)
      scope.order(order_by => direction)
    else
      scope
    end
  end

  def order_by
    params[:order] || DEFAULT_ORDER_BY
  end

  def direction
    params[:direction] || DEFAULT_DIRECTION
  end
end
