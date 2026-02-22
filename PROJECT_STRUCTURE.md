# ME 345 Project Structure

## Top-level entrypoints
- `bj_ui.m`: Interactive UI runner.
- `bj_run_martingale_test.m`: Headless simulation runner with summary output.
- `martingale_strategy_tester.m`: Alias wrapper for strategy testing.
- `bj_setup_paths.m`: Adds project subfolders to MATLAB path.

## Folders
- `engine/`: Core game loop and hand execution logic.
- `rules/`: Blackjack rule evaluation and risk/streak calculations.
- `utils/`: Shared utility helpers (formatting, clamp/div, card values).
- `apps/`: Reserved for future app-level entrypoints.

## Convention
- Put new simulation/gameplay logic in `engine/`.
- Put rule or probability helpers in `rules/`.
- Put general helper functions in `utils/`.
- Keep only user-facing launch files at top-level.
