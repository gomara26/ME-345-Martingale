function [shoe,playerFinal,didDouble]=bj_playPlayer(shoe,player,dealerUpCard,bet,bankroll,props)

didDouble=false;
dealerUp=bj_dealerUpValue(dealerUpCard);

while true
  [tot,soft]=bj_handValueSoft(player);

  if tot>21, playerFinal=player; return; end

  % Doubling is only available on first decision with enough bankroll.
  canDouble = bankroll>=bet && numel(player)==2;
  action=bj_basicAction_simple(tot,soft,dealerUp,props.allowDouble,canDouble);

  if action=="S"
    playerFinal=player; return;
  elseif action=="H"
    [shoe,c]=bj_draw(shoe); player(end+1)=c;
  elseif action=="D"
    didDouble=true;
    [shoe,c]=bj_draw(shoe); player(end+1)=c;
    playerFinal=player; return;
  end
end

end
