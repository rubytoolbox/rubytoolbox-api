# frozen_string_literal: true

RSpec.describe Rubytoolbox::Api::Project do
  let(:json) do
    JSON.parse File.read(File.join(__dir__, "..", "..", "fixtures", "project.json"))
  end
  let(:project) { described_class.new(json) }

  it "has project-related attributes" do
    expect(project).to have_attributes(
      permalink: "simplecov",
      name: "simplecov",
      description: /Code coverage for Ruby/,
      score: kind_of(Float)
    )
  end

  describe "#categories" do
    it "has categories" do
      expect(project.categories).to all(be_a(Rubytoolbox::Api::Category))
    end

    it "has expected category attributes" do
      expect(project.categories.first).to have_attributes(
        permalink: "code_coverage",
        description: /^Utilities/,
        name: "Code Coverage"
      )
    end

    it "wraps category group" do
      expect(project.categories.first.category_group)
        .to be_a(Rubytoolbox::Api::CategoryGroup)
        .and have_attributes(
          permalink: "Code_Quality",
          description: nil,
          name: "Code Quality"
        )
    end

    it "wraps urls" do
      expect(project.categories.first.urls)
        .to be_a(Rubytoolbox::Api::Category::UrlSet)
        .and have_attributes(
          toolbox_url: %r{categories/code_coverage}
        )
    end
  end

  describe "#health" do
    it "is wrapped as health object" do
      expect(project.health).to be_a(Rubytoolbox::Api::Health)
        .and have_attributes(
          overall_level: "green"
        )
    end

    it "wraps all statuses" do
      expect(project.health.statuses).to all(be_a(Rubytoolbox::Api::Health::Status))
    end

    it "has expected attributes on status" do
      expect(project.health.statuses.first).to have_attributes(
        key: "rubygem_long_running",
        icon: "diamond",
        label: /long-lived project/,
        level: "green"
      )
    end
  end

  describe "#urls" do
    # rubocop:disable RSpec/ExampleLength
    it "is is a url set and has expected urls" do
      expect(project.urls).to be_a(described_class::UrlSet)
        .and have_attributes(
          bug_tracker_url: "https://github.com/colszowka/simplecov/issues",
          changelog_url: nil,
          documentation_url: "https://www.rubydoc.info/gems/simplecov/0.18.5",
          homepage_url: "https://github.com/colszowka/simplecov",
          mailing_list_url: "https://groups.google.com/forum/#!forum/simplecov",
          source_code_url: "https://github.com/colszowka/simplecov/tree/v0.18.5",
          toolbox_url: "https://www.ruby-toolbox.com/projects/simplecov",
          wiki_url: nil
        )
    end
    # rubocop:enable RSpec/ExampleLength
  end

  describe "#rubygem" do
    it "is a wrapped rubygem" do
      expect(project.rubygem).to be_a(Rubytoolbox::Api::Rubygem)
        .and have_attributes(
          name: "simplecov",
          current_version: "0.18.5",
          first_release_on: Date.new(2010, 8, 21),
          latest_release_on: Date.new(2020, 2, 25),
          licenses: %w[MIT],
          url: "https://rubygems.org/gems/simplecov"
        )
    end

    describe "#stats" do
      let(:stats) { project.rubygem.stats }

      it "is a stats object with expected attributes" do
        expect(stats).to be_a(Rubytoolbox::Api::Rubygem::Stats)
          .and have_attributes(
            downloads: 92_755_493,
            reverse_dependencies_count: 10_238,
            releases_count: 51
          )
      end

      it "has quarterly_release_counts" do
        expect(stats.quarterly_release_counts).to be_a(Hash)
          .and include("2012-4" => 2)
      end
    end
  end

  describe "#github_repo" do
    let(:repo) { project.github_repo }

    # rubocop:disable RSpec/ExampleLength
    it "is a wrapped github repo with expected attributes" do
      expect(repo).to be_a(Rubytoolbox::Api::GithubRepo)
        .and have_attributes(
          path: "colszowka/simplecov",
          average_recent_committed_at: within(86_400).of(Date.new(2020, 2, 16).to_time),
          description: /Code coverage/,
          is_archived: false,
          is_mirror: false,
          is_fork: false,
          license: "mit",
          primary_language: "Ruby",
          repo_pushed_at: within(86_400).of(Date.new(2020, 3, 11).to_time),
          url: "https://github.com/colszowka/simplecov",
          wiki_url: nil
        )
    end
    # rubocop:enable RSpec/ExampleLength

    it "wraps issues info with expected attributes" do
      expect(repo.issues).to be_a(Rubytoolbox::Api::GithubRepo::Issues)
        .and have_attributes(
          url: "https://github.com/colszowka/simplecov/issues",
          open_count: 49,
          closed_count: 414,
          total_count: 463,
          closure_rate: 89.42
        )
    end

    it "wraps pull request info with expected attributes" do
      expect(repo.pull_requests).to be_a(Rubytoolbox::Api::GithubRepo::PullRequests)
        .and have_attributes(
          url: "https://github.com/colszowka/simplecov/pulls",
          open_count: 3,
          closed_count: 83,
          merged_count: 333,
          total_count: 419,
          acceptance_rate: 79.47
        )
    end

    it "wraps stats with expected attributes" do
      expect(repo.stats).to be_a(Rubytoolbox::Api::GithubRepo::Stats)
        .and have_attributes(
          stargazers_count: 3947,
          forks_count: 429,
          watchers_count: 64
        )
    end
  end
end
