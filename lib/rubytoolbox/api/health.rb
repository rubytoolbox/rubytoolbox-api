# frozen_string_literal: true

module Rubytoolbox
  class Api
    class Health < ResponseWrapper
      class Status < ResponseWrapper
        field :key
        field :icon
        field :label
        field :level
      end

      field :overall_level
      field :statuses do |statuses|
        statuses.map do |status|
          Status.new status
        end
      end
    end
  end
end
