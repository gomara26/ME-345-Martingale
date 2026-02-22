
function shoe = bj_newShoe(numDecks)
cards = 1:(52*numDecks);
cards = cards(randperm(numel(cards)));
shoe.cards = cards;
shoe.initialSize = numel(cards);
end
