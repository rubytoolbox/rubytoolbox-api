# frozen_string_literal: true

module Rubytoolbox
  class Api
    class Category < ResponseWrapper
      class UrlSet < ResponseWrapper
        field :toolbox_url
      end

      field :permalink
      field :name
      field :description
      field :category_group do |category_group|
        CategoryGroup.new category_group
      end
      field :urls do |urls|
        UrlSet.new urls
      end
    end
  end
end
