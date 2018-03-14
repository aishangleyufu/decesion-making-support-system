function [ Fr ] = Gauss_Fr( trnY )%此时对应非线性情况下输入变量X用本块数据作为聚类中心的情况，与其实是体现在Er上的，而与Fr无关，与[ Fr ] = Gauss_Fr_add( trnY )是一样的。
                          
Fr = trnY;

end

