% Computes the between-class, within class and mixture scatter matrices
% of a dataset
%
%  [Sb, Sw, Sm] = tamu_scattermat(x, c)
%    Sb:     between-class scatter matrix
%    Sw:     within-class  scatter matrix
%    Sb:     mixture       scatter matrix
%    x:      database matrix (row vector)
%    clab:   class labels

function [Sb, Sw, Sm] = tamu_scattermat(x, clab)

[ne nd]  = size(x);
[tmp ix] = sort(clab);
x        = x(ix, :);
clab     = clab(ix, :);

nc      = max(clab);
for c=1:nc
  nec(c) = sum(c==clab);
end

mce = [];
for c=1:nc
  rows    = find(c==clab);
  mc(c,:) = mean(x(rows,:));
  mce     = [mce; repmat(mc(c,:), nec(c), 1)];
end;
m = mean(mc);

x0 = x-mce;
Sw = x0'*x0/ne;

Sb = zeros(nd,nd);
for c=1:nc
  Sb = Sb + nec(c)*(mc(c,:)-m)'*(mc(c,:)-m);
end;
Sb = Sb/ne;

Sm = x'*x/(ne-1);
