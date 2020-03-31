# frozen_string_literal: true

module Rubytoolbox
  class Api
    class Rubygem < ResponseWrapper
      class Stats < ResponseWrapper
        field :downloads
        field :reverse_dependencies_count
        field :releases_count

        field :quarterly_release_counts
      end

      field :name
      field :current_version
      field :first_release_on do |date|
        Date.parse(date)
      end
      field :latest_release_on do |date|
        Date.parse(date)
      end
      field :licenses
      field :url

      field :stats do |stats|
        Stats.new stats
      end
    end
  end
end
