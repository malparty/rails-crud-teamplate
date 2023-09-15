# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.filtered(options = {})
    options.compact_blank!

    options.empty? ? all : where(options)
  end
end
