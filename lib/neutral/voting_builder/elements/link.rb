module Neutral
  module VotingBuilder
    module Elements
      class Link
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::UrlHelper

        def initialize(router, icon)
          @router = router
          @icon = icon
        end

        private
        def fa_icon
          "fa #{@icon}"
        end

        def path
          @router[:path]
        end

        def verb
          @router[:method]
        end

        class Positive < Link
          def to_s
            link_to content_tag(:i, nil, class: fa_icon), path, class: 'positive', method: verb, remote: true
          end
        end

        class Negative < Link
          def to_s
            link_to content_tag(:i, nil, class: fa_icon), path, class: 'negative', method: verb, remote: true
          end
        end

        class Remove < Link
          def to_s
            link_to content_tag(:i, nil, class: fa_icon), path, class: 'remove', method: verb, remote: true
          end
        end
      end
    end
  end
end
