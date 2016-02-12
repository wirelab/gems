require 'mandrill'
module Monkey
  class Mandrill
    def initialize(key:)
      @client = ::Mandrill::API.new key
    end

    def send_template template, queue
      to = queue.map do |rcpt|
        {
          email: rcpt[:email],
          name: rcpt[:name]
        }
      end

      merge_vars = queue.map do |rcpt|
        {
          rcpt: rcpt[:email],
          vars: rcpt[:vars].map do |key, value|
            {
              name: key,
              content: value
            }
          end + [{name: 'NAME', content: rcpt[:name]}]
        }
      end

      message = {
        to: to,
        merge_vars: merge_vars,
      }
      @client.messages.send_template template, [], message
    end
  end

  class Queue
    def initialize(template:, client:)
      @template, @client = template, client
      @queue = []
    end

    def queue(email:, name:, **vars)
      @queue << {email: email, name: name, vars: vars}
      self
    end

    def send
      @client.send_template @template, @queue
      @queue.clear
    end
  end
end
