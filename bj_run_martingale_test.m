function [state,summary] = bj_run_martingale_test(numHands,props)
bj_setup_paths();
% Run the blackjack martingale engine without UI.
if nargin < 1 || isempty(numHands)
  numHands = 1000;
end
if nargin < 2
  propsIn = [];
else
  propsIn = props;
end
props = bj_merge_props(propsIn);

state = bj_engine_init(props);

for k = 1:numHands
  bankrollBefore = state.bankroll;
  state = bj_engine_step(state);

  % Stop early if engine stop condition was reached.
  if state.stop.hit
    break;
  end

  % Stop early if bankroll can no longer cover the next required bet.
  if state.bankroll == bankrollBefore && state.bankroll < state.betNext
    break;
  end
end

handsPlayed = state.handN;
net = state.bankroll - props.bankroll0;

summary = struct();
summary.handsPlayed = handsPlayed;
summary.bankrollStart = props.bankroll0;
summary.bankrollEnd = state.bankroll;
summary.maxBankrollReached = max([props.bankroll0, state.history.bankroll]);
summary.net = net;
summary.roi = bj_safeDiv(net, props.bankroll0);
summary.wins = state.wins;
summary.losses = state.losses;
summary.pushes = state.pushes;
summary.winRateNoPush = bj_safeDiv(state.wins, state.wins + state.losses);
summary.lossRateNoPush = bj_safeDiv(state.losses, state.wins + state.losses);
summary.stoppedByBankroll = state.stop.hit || (handsPlayed < numHands);
summary.stopReason = state.stop.reason;
summary.stopLossesInRow = state.stop.lossesInRow;
summary.maxLossStreak = state.maxLossStreak;
end

function propsOut = bj_merge_props(propsIn)
propsOut = bj_default_props();
if nargin < 1 || isempty(propsIn)
  return;
end
f = fieldnames(propsIn);
for i = 1:numel(f)
  propsOut.(f{i}) = propsIn.(f{i});
end
end

function props = bj_default_props()
props = struct( ...
  'numDecks', 6, ...
  'bankroll0', 1000, ...
  'tableMin', 10, ...
  'tableMax', 500, ...
  'baseBet', 10, ...
  'bjPayout', 1.5, ...
  'dealerStandS17', true, ...
  'allowDouble', false, ...
  'reshufflePen', 0.25, ...
  'stopAtTableMax', false, ...
  'seed', [] ...
);
end
