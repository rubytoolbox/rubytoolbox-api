# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rubytoolbox::Api::ResponseWrapper do
  sub = Class.new(Rubytoolbox::Api::ResponseWrapper) do
    field :key
  end

  sample = Class.new(described_class) do
    field :foo
    field :bar, &:reverse

    field :sub do |input|
      sub.new input
    end

    field :subcollection do |inputs|
      inputs.map do |input|
        sub.new(input)
      end
    end
  end

  it "wraps given data as attributes of the class" do
    expect(sample.new(foo: "foo", bar: "bar")).to have_attributes(
      foo: "foo",
      bar: "rab"
    )
  end

  it "correctly handles false value when given as string key" do
    expect(sample.new("foo" => false, bar: "123").foo).to be false
  end

  it "can be converted back to a hash" do # rubocop:disable RSpec/ExampleLength
    object = sample.new(
      foo: "foo",
      bar: "bar",
      sub: { key: "value" },
      subcollection: [{ key: "value" }]
    )

    expect(object.to_h).to eq(
      "foo" => "foo",
      "bar" => "rab",
      "sub" => {
        "key" => "value",
      },
      "subcollection" => [
        { "key" => "value" },
      ]
    )
  end
end
