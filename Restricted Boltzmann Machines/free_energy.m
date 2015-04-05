function [logww] = free_energy(vv,beta_k1,beta_k0,visbiases_base,visbiases,hidbias,vishid)

 [numcases,numdims] = size(vv); 
 temp_base = vv*visbiases_base'; 
 temp_bias = vv*visbiases'; 
 tempvWh = hidbias + (vv*vishid);  

 aa = beta_k1; 
 p_star_k1  = (1-aa)*temp_base  + aa*temp_bias + sum(log(1+exp(aa*tempvWh)),2);

 aa = beta_k0;
 p_star_k0  =  (1-aa)*temp_base + aa*temp_bias + sum(log(1+exp(aa*tempvWh)),2);

 logww = (p_star_k1 - p_star_k0);




