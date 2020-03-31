# frozen_string_literal: true

module Rubytoolbox
  class Api
    class CategoryGroup < ResponseWrapper
      field :permalink
      field :name
      field :description
    end
  end
end
