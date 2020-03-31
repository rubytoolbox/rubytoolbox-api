# frozen_string_literal: true

require "time"

module Rubytoolbox
  class Api
    class GithubRepo < ResponseWrapper
      class Stats < ResponseWrapper
        field :stargazers_count
        field :forks_count
        field :watchers_count
      end

      class Issues < ResponseWrapper
        field :url
        field :open_count
        field :closed_count
        field :total_count
        field :closure_rate, &:to_f
      end

      class PullRequests < ResponseWrapper
        field :url
        field :open_count
        field :closed_count
        field :merged_count
        field :total_count
        field :acceptance_rate, &:to_f
      end

      field :path
      field :average_recent_committed_at do |time|
        Time.parse(time)
      end
      field :description
      field :is_archived
      field :is_fork
      field :is_mirror
      field :license
      field :primary_language

      field :repo_pushed_at do |time|
        Time.parse(time)
      end

      field :url
      field :wiki_url

      field :stats do |stats|
        Stats.new stats
      end

      field :issues do |issues|
        Issues.new issues
      end

      field :pull_requests do |pull_requests|
        PullRequests.new pull_requests
      end
    end
  end
end
