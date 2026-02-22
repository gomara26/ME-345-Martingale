function [pLossEst, maxLossesLeft, pStreak] = bj_bust_streak_est(state)
% Estimate P(lose L straight) using observed loss rate so far (ignoring pushes)

pLossEst = bj_safeDiv(state.losses, (state.wins + state.losses));

maxLossesLeft = bj_lossesToStop( ...
  state.bankroll, ...
  bj_clamp(state.betNext, state.props.tableMin, state.props.tableMax), ...
  state.props.tableMax);

pStreak = pLossEst ^ maxLossesLeft;
end