# three_percent_signal
Calculate scenarios based on the Three Percent Signal by Jason Kelley


### Dependencies ###

[Ruby 2.7.3](https://www.ruby-lang.org/en/news/2021/04/05/ruby-2-7-3-released/)

Thor    (from ```bundle install```)

Rubocop (from ```bundle install```)


### Example ###


```
bundle install


# Based on Jason Kelley's data from "more details #1 and #2" from pages 160-161

# quarterly
# using the 'quarterly' subcommand

ruby three_percent_signal.rb quarterly \
  --quarterly_additions 660 \
  --current_stock_price 49.17 \
  --starting_balance 12845 \
  --ending_balance 12976
---------------------------------------------------------
signal_line:    $13560.35
buy:            11.88 shares


ruby three_percent_signal.rb quarterly \
  --quarterly_additions 660 \
  --current_stock_price 53.47 \
  --starting_balance 12845 \
  --ending_balance 14110
---------------------------------------------------------
signal_line:    $13560.35
sell:           10.28 shares


# prediction
# using the 'prediction' subcommand

ruby three_percent_signal.rb prediction \
  --quarters 40 \
  --quarterly_additions 3000 \
  --starting_balance 12976
---------------------------------------------------------
ending_balance: 155430.1


```
