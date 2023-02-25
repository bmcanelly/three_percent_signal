# three_percent_signal
Calculate scenarios based on the Three Percent Signal by Jason Kelley


### Dependencies ###

[Ruby 3.1.3](https://www.ruby-lang.org/en/downloads/)

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


# quarterly_compounded_interest
# using the 'quarterly_compounded_interest' subcommand

ruby three_percent_signal.rb quarterly_compounded_interest \
  --rate 0.045 \
  --starting_balance 1000000 \
  --years 2
---------------------------------------------------------
ending_balance: 1093898.39 


```
