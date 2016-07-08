def sigpow(n)
	return n*n*n*n*n*n*n;
end

sum=0;
ARGV.each do |n|
	sum+=sigpow(n.to_i);
end
puts sum;