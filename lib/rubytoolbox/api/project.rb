# frozen_string_literal: true

module Rubytoolbox
  class Api
    class Project < ResponseWrapper
      class UrlSet < ResponseWrapper
        field :bug_tracker_url
        field :changelog_url
        field :documentation_url
        field :homepage_url
        field :mailing_list_url
        field :source_code_url
        field :toolbox_url
        field :wiki_url
      end

      field :description
      field :name
      field :permalink
      field :score, &:to_f

      field :categories do |categories|
        categories.map { |category| Category.new category }
      end

      field :github_repo do |github_repo|
        GithubRepo.new github_repo
      end

      field :health do |health|
        Health.new health
      end

      field :rubygem do |rubygem|
        Rubygem.new rubygem
      end

      field :urls do |urls|
        UrlSet.new urls
      end
    end
  end
end
