# ME 345 Blackjack Martingale Simulator

MATLAB blackjack simulator with:
- UI mode (`bj_ui`)
- Headless mode (`martingale_strategy_tester` / `bj_run_martingale_test`)

## 1. Open project


## 2. Run UI
```matlab
bj_ui
```

## 3. Parameter reference
- `numDecks`: Number of decks in the shoe.
- `bankroll0`: Starting bankroll.
- `tableMin`: Table minimum bet.
- `tableMax`: Table maximum bet.
- `baseBet`: Martingale base/reset bet.
- `bjPayout`: Blackjack payout multiplier (typically `1.5`).
- `dealerStandS17`: `true` for dealer stands on soft 17; `false` hits soft 17.
- `allowDouble`: Enables/disables player double-down logic.
- `reshufflePen`: Fraction of original shoe size that triggers reshuffle.
- `stopAtTableMax`: `true` stops the run when the next required bet reaches `tableMax`; `false` keeps playing at the cap.
- `seed`: RNG seed for reproducible runs.
  - Use `[]` for random runs each start/reset.

## 4. Run headless
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
  'stopAtTableMax', false, ...
  'seed', 42 ...
);

[state, summary] = martingale_strategy_tester(10000, props);
disp(summary)
```

## 5. Notes
- Entry points auto-call `bj_setup_paths`, so subfolders are loaded automatically.
- Main entry points:
  - `bj_ui`
  - `bj_run_martingale_test`
  - `martingale_strategy_tester`

## 6. Realism scope
Current model matches core blackjack flow (shoe dealing, naturals, S17/H17, doubling, bankroll settlement), but it is not a full casino rules engine yet.

Not yet modeled:
- Splits (including re-splits and split aces rules)
- Surrender
- Insurance / even money
- Side bets
- Table-specific double restrictions beyond current toggle
