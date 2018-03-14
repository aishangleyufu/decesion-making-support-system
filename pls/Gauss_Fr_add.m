function [ Ft ] = Gauss_Fr_add( tstY )%此时对应非线性情况下输入变量X用非本块数据作为聚类中心的情况，其实是体现在Er上的，而与Fr无关，与[ Fr ] = Gauss_Fr( trnY )是一样的。

Ft = tstY;


end


