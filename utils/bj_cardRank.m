function r = bj_cardRank(card)
% Map card id to rank 1..13 (A..K), independent of deck index.
r = mod(card - 1, 13) + 1;
end
