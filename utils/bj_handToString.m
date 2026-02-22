function s=bj_handToString(hand)
parts=strings(1,numel(hand));
for i=1:numel(hand), parts(i)=bj_cardToString(hand(i)); end
s=strjoin(parts," ");
end