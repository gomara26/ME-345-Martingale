function s=bj_cardToString(card)
names=["A","2","3","4","5","6","7","8","9","10","J","Q","K"];
suits=["S","H","D","C"];
rank = bj_cardRank(card);
deckCard = mod(card - 1, 52) + 1;
suitIdx = floor((deckCard - 1)/13) + 1;
s = names(rank) + suits(suitIdx);
end
