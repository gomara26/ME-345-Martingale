function state = bj_engine_init(props)

if isfield(props,'seed') && ~isempty(props.seed)
  rng(props.seed);
else
  rng('shuffle');
end

state.props = props;
state.bankroll = props.bankroll0;
state.baseBet = bj_clamp(props.baseBet,props.tableMin,props.tableMax);
state.betNext = state.baseBet;

state.handN=0;
state.wins=0; state.losses=0; state.pushes=0;
state.currentLossStreak=0;
state.maxLossStreak=0;

state.shoe=bj_newShoe(props.numDecks);

state.history.bankroll=[];
state.history.bet=[];
state.history.outcome=[];
state.history.pBustStreak=[];
state.history.lossStreak=[];

state.last.playerText="";
state.last.dealerText="";
state.last.playerCards=[];
state.last.dealerCards=[];

state.stop.hit=false;
state.stop.handN=[];
state.stop.bankroll=[];
state.stop.nextBet=[];
state.stop.lossesInRow=[];
state.stop.reason="";

end
