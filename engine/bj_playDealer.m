function [shoe,dealerFinal]=bj_playDealer(shoe,dealer,props)

while true
  [tot,soft]=bj_handValueSoft(dealer);

  if tot>21, dealerFinal=dealer; return; end
  % Dealer policy: hit below 17; optionally hit soft 17 when configured.
  if tot<17
    [shoe,c]=bj_draw(shoe); dealer(end+1)=c; continue;
  end
  if tot==17 && soft && ~props.dealerStandS17
    [shoe,c]=bj_draw(shoe); dealer(end+1)=c; continue;
  end

  dealerFinal=dealer; return;
end

end
