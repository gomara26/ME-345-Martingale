function [total,isSoft] = bj_handValueSoft(hand)
vals = arrayfun(@bj_cardValue, hand);
total = sum(vals);
numAces = sum(arrayfun(@bj_cardRank, hand) == 1);
isSoft = false;

while numAces > 0 && total + 10 <= 21
  total = total + 10;
  numAces = numAces - 1;
  isSoft = true;
end
end
