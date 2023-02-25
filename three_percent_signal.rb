# frozen_string_literal: true

require 'thor'

# class ThreePercentSignal
class ThreePercentSignal < Thor
  include Thor::Actions

  package_name 'ThreePercentSignal'

  class_option 'starting_balance', aliases: '-s', type: :numeric, required: true

  THREE_PERCENT = 0.03

  def initialize(*args)
    super
    @balance   = options[:starting_balance].to_f
    @additions = options[:quarterly_additions] / 2 if options[:quarterly_additions]
  end

  def self.exit_on_failure?
    true
  end

  no_commands do
    def amount
      ((@signal_line - options[:ending_balance]) / options[:current_stock_price]).round(2)
    end

    def calculate(data)
      @balance = ((data * (1 + THREE_PERCENT)) + @additions).round(2)
    end

    def display(data)
      format = '%-15.15s %-30.30s'
      puts format % data
    end

    def header
      say '---------------------------------------------------------', :green
    end

    def compounded_interest(options)
      # A = P * (1 + r/n) ** (n * t)
      rate     = options[:rate].to_f
      @balance = 0.01 unless @balance.positive?
      @balance = (@balance * ((1 + (rate / (options[:years] * 4)))**((options[:years] * 4) * options[:years]))).round(2)
    end
  end

  desc 'quarterly_compounded_interest', 'calculate quarterly compounded interest '
  method_option 'rate',  aliases: '-r', type: :numeric, required: true
  method_option 'years', aliases: '-y', type: :numeric, required: true
  def quarterly_compounded_interest
    header
    display(['ending_balance: ', compounded_interest(**options)])
  end

  desc 'quarterly', 'calculate action for the quarter'
  method_option 'current_stock_price', aliases: '-c', type: :numeric, required: true
  method_option 'ending_balance',      aliases: '-e', type: :numeric, required: true
  method_option 'quarterly_additions', aliases: '-q', type: :numeric, required: true
  def quarterly
    header
    @signal_line = calculate(@balance)
    display(['signal_line:', "$#{@signal_line}"])
    action = amount.negative? ? 'sell' : 'buy'
    display(["#{action}: ", "#{amount.abs} shares"])
  end
end

ThreePercentSignal.start(ARGV)
