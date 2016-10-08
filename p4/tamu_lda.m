% Linear Discriminant Analysis
%
%  [y, v, d] = tamu_lda(x, clab);
%    y:       projected data, y = x*v
%    v:       eigenvectors matrix (column vectors)
%    d:       eigenvalues vector
%    x:       database matrix (row vectors)
%    clab:    class labels

function [y, v, d] = tamu_lda(x, clab);

if isempty(x)
  fprintf('lda(): empty matrix\n');
  y = [];
  v = [];
  d = [];
  return;
end;

nc = max(clab);
nf = size(x,2);

[Sb, Sw, Sm] = tamu_scattermat(x, clab);
[v1, d1]     = eig(pinv(Sw)*Sb, 'nobalance');

% Sort axis by decreasing eigenvalues

d1 = diag(d1);
[dmy, ix] = sort(-real(d1));
d1 = d1(ix);
v1 = v1(:,ix);

% Eliminate irrelevant dimensions and project data

d    = d1(1:min(nf,(nc-1)));
maxd = max(d);
nd   = sum(d>maxd/100);
nd = min([nf nc-1]);

d = d(1:nd);
v = v1(:,1:nd);
y = x*v;

