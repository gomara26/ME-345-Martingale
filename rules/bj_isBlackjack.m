function tf = bj_isBlackjack(hand)
if numel(hand) ~= 2
  tf = false;
  return;
end

vals = sort([bj_cardValue(hand(1)), bj_cardValue(hand(2))]);
tf = (vals(1) == 1) && (vals(2) == 10);
end
