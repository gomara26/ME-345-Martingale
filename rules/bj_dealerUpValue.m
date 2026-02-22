function up = bj_dealerUpValue(card)
if bj_cardRank(card) == 1
  up = 11;
else
  up = bj_cardValue(card);
end
end
