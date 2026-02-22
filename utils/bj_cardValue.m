function v=bj_cardValue(card)
rank = bj_cardRank(card);
if rank==1, v=1; elseif rank>=10, v=10; else, v=rank; end
end
