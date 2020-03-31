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

  it "correctly handles false value when given as string key" do
    expect(sample.new("foo" => false, bar: "123").foo).to be == false
  end
end
