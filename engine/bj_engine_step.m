function state = bj_engine_step(state)

props=state.props;
bet=bj_clamp(state.betNext,props.tableMin,props.tableMax);

% Hard stop when bankroll cannot fund the next hand.
if state.bankroll<bet
  if ~state.stop.hit
    state.stop.hit = true;
    state.stop.handN = state.handN;
    state.stop.bankroll = state.bankroll;
    state.stop.nextBet = bet;
    state.stop.lossesInRow = state.currentLossStreak;
    state.stop.reason = "BANKROLL";
    fprintf('STOP hit at hand %d: bankroll $%.0f below next bet $%.0f after %d consecutive losses.\n', ...
      state.stop.handN, state.stop.bankroll, state.stop.nextBet, state.stop.lossesInRow);
  end
  return
end

% Optional stop when the martingale progression reaches table limit.
if isfield(props,'stopAtTableMax') && props.stopAtTableMax && bet>=props.tableMax
  if ~state.stop.hit
    state.stop.hit = true;
    state.stop.handN = state.handN;
    state.stop.bankroll = state.bankroll;
    state.stop.nextBet = bet;
    state.stop.lossesInRow = state.currentLossStreak;
    state.stop.reason = "TABLE_MAX";
    fprintf('STOP hit at hand %d: next bet reached table max ($%.0f).\n', ...
      state.stop.handN, state.stop.nextBet);
  end
  return
end

% Keep a cut-card style reshuffle trigger so long runs do not exhaust the shoe.
cardsRemaining = numel(state.shoe.cards);
cardsThreshold = max(15, round(state.shoe.initialSize * props.reshufflePen));
if cardsRemaining <= cardsThreshold
  state.shoe = bj_newShoe(props.numDecks);
end

state.handN=state.handN+1;
bankrollBefore=state.bankroll;
state.bankroll=state.bankroll-bet;

% Deal opening two cards each and resolve hand flow.
[state.shoe,p1]=bj_draw(state.shoe); [state.shoe,d1]=bj_draw(state.shoe);
[state.shoe,p2]=bj_draw(state.shoe); [state.shoe,d2]=bj_draw(state.shoe);

player=[p1 p2];
dealer=[d1 d2];
dealerUp=d1;

playerFinal=player;
dealerFinal=dealer;

didDouble=false;
profit=0;
actualBet=bet;
outcome="P";

if bj_isBlackjack(player)&&~bj_isBlackjack(dealer)
  profit=bet*props.bjPayout+bet; outcome="BJW"; state.wins=state.wins+1;

elseif bj_isBlackjack(dealer)&&~bj_isBlackjack(player)
  outcome="BJL"; state.losses=state.losses+1;

elseif bj_isBlackjack(player)&&bj_isBlackjack(dealer)
  profit=bet; state.pushes=state.pushes+1;

else

  [state.shoe,playerFinal,didDouble]=bj_playPlayer(state.shoe,player,dealerUp,bet,state.bankroll,props);

  if didDouble && state.bankroll>=bet
    state.bankroll=state.bankroll-bet;
    actualBet=2*bet;
  end

  if bj_isBust(playerFinal)
    outcome="L"; state.losses=state.losses+1;

  else
    [state.shoe,dealerFinal]=bj_playDealer(state.shoe,dealer,props);

    if bj_isBust(dealerFinal)
      profit=actualBet*2; outcome="W"; state.wins=state.wins+1;
    else
      pv=bj_handValue(playerFinal); dv=bj_handValue(dealerFinal);
      if pv>dv
        profit=actualBet*2; outcome="W"; state.wins=state.wins+1;
      elseif pv<dv
        outcome="L"; state.losses=state.losses+1;
      else
        profit=actualBet; state.pushes=state.pushes+1;
      end
    end
  end
end

state.bankroll=state.bankroll+profit;

% Track consecutive losses for risk/stop diagnostics.
if outcome=="L"||outcome=="BJL"
  state.currentLossStreak = state.currentLossStreak + 1;
else
  state.currentLossStreak = 0;
end
state.maxLossStreak = max(state.maxLossStreak,state.currentLossStreak);

% Martingale bet update: double after loss, reset after win, hold on push.
if outcome=="L"||outcome=="BJL"
  state.betNext=min(bet*2,props.tableMax);
elseif outcome=="W"||outcome=="BJW"
  state.betNext=state.baseBet;
else
  state.betNext=bet;
end

state.history.bankroll(end+1)=state.bankroll;
state.history.bet(end+1)=actualBet;
state.history.outcome(end+1)=outcome;
state.history.lossStreak(end+1)=state.currentLossStreak;

[pLoss,maxLoss,pStreak]=bj_bust_streak_est(state);
state.history.pBustStreak(end+1)=pStreak;

net=state.bankroll-bankrollBefore;

state.last.playerText=sprintf("PLAYER\nTotal %d\nDouble %s\nOutcome %s\nNet %+0.0f", ...
  bj_handValue(playerFinal),bj_tfStr(didDouble),outcome,net);

state.last.dealerText=sprintf("DEALER\nUpcard %s\nTotal %d", ...
  bj_cardToString(dealerUp),bj_handValue(dealerFinal));
state.last.playerCards=playerFinal;
state.last.dealerCards=dealerFinal;

end
