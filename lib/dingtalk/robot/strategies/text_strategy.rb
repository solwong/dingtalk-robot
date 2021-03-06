# frozen_string_literal: true

module Dingtalk
  class Robot
    # Text type strategy for sending message
    class TextStrategy
      def initialize(webhook_url, message)
        @webhook_url = webhook_url
        @message = message
      end

      # @option options [Array<String>] :at_mobiles
      # @option options [Boolean]       :is_at_all
      def notify(**options)
        at_mobiles = options[:at_mobiles].to_a
        is_at_all  = options[:is_at_all] ? true : false
        body = generate_body(at_mobiles, is_at_all)
        headers = {
          'Content-Type': 'application/json',
          Accept: 'application/json'
        }
        Net::HTTP.post(URI(webhook_url), body.to_json, headers).body
      end

      private

      attr_reader :webhook_url, :message

      def generate_body(at_mobiles, is_at_all)
        {
          msgtype: :text,
          text: {
            content: message
          },
          at: {
            atMobiles: at_mobiles,
            isAtAll: is_at_all
          }
        }
      end
    end
  end
end
