# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rubytoolbox::Api::ResponseWrapper do
  sample = Class.new(described_class) do
    field :foo
    field :bar, &:reverse
  end

  it "wraps given data as attributes of the class" do
    expect(sample.new(foo: "foo", bar: "bar")).to have_attributes(
      foo: "foo",
      bar: "rab"
    )
  end
end
