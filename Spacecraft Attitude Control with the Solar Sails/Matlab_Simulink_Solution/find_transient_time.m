function transient_time = find_transient_time(threshold, t, data)

% Time Samples of Simulink
t_simulink_reverse = flip(t);

% Datas
data_reverse = flip(data);

% Indexes
indexes = find(abs(data_reverse) < threshold);

N = size(indexes,1);

for j = 1 : N - 1
    
  t_interval = t_simulink_reverse(indexes(j)) ...
  - t_simulink_reverse(indexes(j+1));

  t_samp_simulink = t_simulink_reverse(indexes(j)) - t_simulink_reverse(indexes(j)+1);

  if j == N - 1
    break;
  end
  
  if t_interval > t_samp_simulink
     break;
  end
end

transient_time = t_simulink_reverse(indexes(j));

end

