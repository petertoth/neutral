module Neutral
  module Helpers
    module Routes
      def neutral
        mount Neutral::Engine => '/neutral', as: 'neutral'
      end
    end
  end
end
