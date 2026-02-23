function [state,summary] = martingale_strategy_tester(numHands,props)
% Convenience wrapper around bj_run_martingale_test.
bj_setup_paths();
if nargin < 1
  numHands = [];
end
if nargin < 2
  props = [];
end
[state,summary] = bj_run_martingale_test(numHands,props);
end
