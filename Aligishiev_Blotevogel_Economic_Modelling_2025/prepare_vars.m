    for mm = 1:size(select_varrs,1)
      eval(string(select_varrs(mm)) + '_s' + string(iiii) + ' = ' + select_varrs(mm) +'(1:T);');
    end

    eval('GI_s'+ string(iiii) + ' = PG(1:T).*(GI(1:T));');
    eval('DC_s'+ string(iiii) + ' = D(1:T)+DC(1:T);');
    eval('TOT_s'+ string(iiii) + ' = S(1:T)./PTH(1:T);');
    eval('NX_s'+ string(iiii) + ' = PTH(1:T).*XX(1:T) - S(1:T).*(MM_TOTAL(1:T));');