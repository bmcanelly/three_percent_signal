# frozen_string_literal: true

require 'thor'

# class ThreePercentSignal
class ThreePercentSignal < Thor
  include Thor::Actions

  package_name 'ThreePercentSignal'

  class_option 'quarterly_additions',
               aliases: '-q', type: :numeric, required: true
  class_option 'starting_balance',
               aliases: '-s', type: :numeric, required: true

  PERCENT = 0.03

  def initialize(*args)
    super
    @balance = options[:starting_balance]
    @additions = options[:quarterly_additions] / 2
  end

  def self.exit_on_failure?
    true
  end

  no_commands do
    def amount
      ((@signal_line - options[:ending_balance]) \
        / options[:current_stock_price])
        .round(2)
    end

    def calculate(data)
      @balance = (data * (1 + PERCENT) + @additions).round(2)
    end

    def display(data)
      format = '%-15.15s %-30.30s'
      puts format % data
    end

    def header
      say '---------------------------------------------------------', :green
    end
  end

  desc 'prediction', 'calculate based on number of quarters'
  method_option 'quarters', type: :numeric, required: true
  def prediction
    header
    options[:quarters].to_i.times { calculate(@balance) }
    display(['ending_balance: ', @balance])
  end

  desc 'quarterly', 'calculate action for the quarter'
  method_option 'current_stock_price',
                aliases: '-c', type: :numeric, required: true
  method_option 'ending_balance',
                aliases: '-e', type: :numeric, required: true
  def quarterly
    header
    @signal_line = calculate(@balance)
    display(['signal_line:', "$#{@signal_line}"])
    action = amount.negative? ? 'sell' : 'buy'
    display(["#{action}: ", "#{amount.abs} shares"])
  end
end

ThreePercentSignal.start(ARGV)
