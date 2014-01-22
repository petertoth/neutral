module Neutral
  module VotingBuilder
    module Elements
      class Span
        include ActionView::Helpers::TagHelper

        def initialize(total)
          @total = total
        end

        private
        def total
          @total.nonzero?
        end

        class Positive < Span
          def to_s
            content_tag :span, total, class: 'positive'
          end
        end

        class Negative < Span
          def to_s
            content_tag :span, total, class: 'negative'
          end
        end

        class Difference < Span
          def to_s
            content_tag :span, total.try(:abs), class: "difference #{color}"
          end

          private
          def color
            total > 0 ? 'positive' : 'negative' if total
          end
        end
      end
    end
  end
end
