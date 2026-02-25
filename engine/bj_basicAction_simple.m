function action=bj_basicAction_simple(total,soft,dealerUp,allowDouble,canDouble)

% Approximate no-split basic strategy used by the simulator.
if soft
  if total<=17, action="H"; return; end
  if total==18
    if allowDouble&&canDouble&&dealerUp>=3&&dealerUp<=6, action="D"; return; end
    if dealerUp==2||dealerUp==7||dealerUp==8, action="S"; else, action="H"; end
    return;
  end
  action="S"; return;
end

if total<=8, action="H"; return; end
if total==9
  if allowDouble&&canDouble&&dealerUp>=3&&dealerUp<=6, action="D"; else, action="H"; end
  return;
end
if total==10
  if allowDouble&&canDouble&&dealerUp<=9, action="D"; else, action="H"; end
  return;
end
if total==11
  if allowDouble&&canDouble, action="D"; else, action="H"; end
  return;
end
if total==12
  if dealerUp>=4&&dealerUp<=6, action="S"; else, action="H"; end
  return;
end
if total>=13&&total<=16
  if dealerUp>=2&&dealerUp<=6, action="S"; else, action="H"; end
  return;
end
action="S";

end
