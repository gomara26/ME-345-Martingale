# ME 345 Blackjack Martingale Tester

MATLAB blackjack simulator with:
- UI mode (`bj_ui`)
- Headless test mode (`martingale_strategy_tester` / `bj_run_martingale_test`)

## 1. Open project
In MATLAB:
```matlab
cd('/Users/gavinomara/Documents/MATLAB/ME 345 Project')
```

## 2. Run UI
```matlab
bj_ui
```

The UI uses default martingale settings (`allowDouble = false`).
Hands are shown as rank+suit card codes (example: `AS`, `10H`, `QC`).

## 3. Run headless tester (default params)
```matlab
[state, summary] = martingale_strategy_tester(5000);
disp(summary)
```

`summary` includes:
- `handsPlayed`
- `bankrollStart`
- `bankrollEnd`
- `net`
- `roi`
- `wins`
- `losses`
- `pushes`
- `winRateNoPush`
- `lossRateNoPush`
- `stoppedByBankroll`
- `stopLossesInRow`
- `maxLossStreak`

## 4. Run with custom params
```matlab
props = struct( ...
  'numDecks', 6, ...
  'bankroll0', 2000, ...
  'tableMin', 25, ...
  'tableMax', 1000, ...
  'baseBet', 25, ...
  'bjPayout', 1.5, ...
  'dealerStandS17', true, ...
  'allowDouble', false, ...
  'reshufflePen', 0.25, ...
  'seed', 42 ...
);

[state, summary] = martingale_strategy_tester(10000, props);
disp(summary)
```

You can also pass a partial struct; missing fields use defaults:
```matlab
props = struct('bankroll0', 5000, 'baseBet', 50, 'seed', 99);
[state, summary] = martingale_strategy_tester(20000, props);
```

## 5. Parameter reference
- `numDecks`: Number of decks in the shoe.
- `bankroll0`: Starting bankroll.
- `tableMin`: Table minimum bet.
- `tableMax`: Table maximum bet.
- `baseBet`: Martingale base/reset bet.
- `bjPayout`: Blackjack payout multiplier (typically `1.5`).
- `dealerStandS17`: `true` for dealer stands on soft 17; `false` hits soft 17.
- `allowDouble`: Enables/disables player double-down logic.
- `reshufflePen`: Fraction of original shoe size that triggers reshuffle.
- `seed`: RNG seed for reproducible runs.
  - Use `[]` for random runs each start/reset.

## 6. Notes
- Entry points auto-call `bj_setup_paths`, so subfolders are loaded automatically.
- Main entry points:
  - `bj_ui`
  - `bj_run_martingale_test`
  - `martingale_strategy_tester`

## 7. Realism scope
Current model matches core blackjack flow (shoe dealing, naturals, S17/H17, doubling, bankroll settlement), but it is not a full casino rules engine yet.

Not yet modeled:
- Splits (including re-splits and split aces rules)
- Surrender
- Insurance / even money
- Side bets
- Table-specific double restrictions beyond current toggle
# ME-345-Martingale
# ME-345-Martingale
