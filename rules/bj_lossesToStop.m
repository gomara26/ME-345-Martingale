function L=bj_lossesToStop(bankroll,startingBet,tableMax)
L=0; b=startingBet; B=bankroll;
while true
  b=min(b,tableMax);
  if B<b, return; end
  B=B-b; L=L+1; b=2*b;
end
end