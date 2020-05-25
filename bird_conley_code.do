*******************************************************************************
******"Neonicotinoids and Decline in Bird Biodiversity in the United States"
****** Authors: Yijia Li, Madhu Khanna and Ruiqing Miao

**Note: data and code should be downloaded and saved in the same folder.
**To calculate the spatial robust standard errors, one should run the ols_spatial_HAC.ado file first.
*******************************************************************************


****************************************************************************
***Table S4
****************************************************************************
***grassland birds
foreach x in sum_grass_no  spnumber sum_shannon  {
use  grassland_birds_county.dta, clear
 

drop if total_neon==. | total_neon==0


xtset fips year


***FE-IV regression
xtivreg2  `x' develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (crop_acre  total_neon  = lag_fertp pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in crop_acre  total_neon develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort fips: drop if _N==1

qui xtreg crop_acre  lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict crop_ac, xb


qui xtreg total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' crop_ac neon crop_acre total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den {

 egen double `j'bar = mean(`j'), by(fips)
 gen `j'd = `j'-`j'bar
 * drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd crop_acd neond develop_acred lag_mtemp12d mtemp1d mtemp4d mtemp5d mtemp6d lag_pcpn12d pcpn1d pcpn4d pcpn5d pcpn6d  pop_dend , lat(lat) lon(lon) t(year) p(fips) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab fips
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd - _b[crop_acd]*crop_acred -_b[neond]*total_neond -_b[develop_acred]*develop_acred  -_b[lag_pcpn12d]*lag_pcpn12d-_b[pcpn1d]*pcpn1d-_b[pcpn4d]*pcpn4d-_b[pcpn5d]*pcpn5d-_b[pcpn6d]*pcpn6d-_b[lag_mtemp12d]*lag_mtemp12d-_b[mtemp1d]*mtemp1d-_b[mtemp4d]*mtemp4d-_b[mtemp5d]*mtemp5d-_b[mtemp6d]*mtemp6d -_b[pop_dend]*pop_dend)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V,dof(`dof')
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conley.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"
  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se 
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}



****************************************************************************
***Non-grassland birds
foreach x in sum_ngrass_no ngrspnumber sum_shannonngr {
use  non-grassland_birds_county, clear

drop if total_neon==. | total_neon==0


xtset fips year


***FE-IV regression
xtivreg2  `x' develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (crop_acre  total_neon  = lag_fertp pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in crop_acre  total_neon develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort fips: drop if _N==1

qui xtreg crop_acre  lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict crop_ac, xb


qui xtreg total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' crop_ac neon crop_acre total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den {

 egen double `j'bar = mean(`j'), by(fips)
 gen `j'd = `j'-`j'bar
  drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd crop_acd neond develop_acred lag_mtemp12d mtemp1d mtemp4d mtemp5d mtemp6d lag_pcpn12d pcpn1d pcpn4d pcpn5d pcpn6d  pop_dend , lat(lat) lon(lon) t(year) p(fips) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab fips
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd - _b[crop_acd]*crop_acred -_b[neond]*total_neond -_b[develop_acred]*develop_acred  -_b[lag_pcpn12d]*lag_pcpn12d-_b[pcpn1d]*pcpn1d-_b[pcpn4d]*pcpn4d-_b[pcpn5d]*pcpn5d-_b[pcpn6d]*pcpn6d-_b[lag_mtemp12d]*lag_mtemp12d-_b[mtemp1d]*mtemp1d-_b[mtemp4d]*mtemp4d-_b[mtemp5d]*mtemp5d-_b[mtemp6d]*mtemp6d -_b[pop_dend]*pop_dend)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V,dof(`dof')
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conley.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"
  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}



****************************************************************************
***Table S5
****************************************************************************
***insectivorous birds

foreach x in sum_insect_no insspnumber inssum_shannon {
use  insectivorous_birds_county clear
     
	 
drop if total_neon==. | total_neon==0


xtset fips year


***FE-IV regression
xtivreg2  `x' develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (crop_acre  total_neon  = lag_fertp pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in crop_acre  total_neon develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se one at a time
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort fips: drop if _N==1

qui xtreg crop_acre  lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict crop_ac, xb


qui xtreg total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' crop_ac neon crop_acre total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den {

 egen double `j'bar = mean(`j'), by(fips)
 gen `j'd = `j'-`j'bar
  drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd crop_acd neond develop_acred lag_mtemp12d mtemp1d mtemp4d mtemp5d mtemp6d lag_pcpn12d pcpn1d pcpn4d pcpn5d pcpn6d  pop_dend , lat(lat) lon(lon) t(year) p(fips) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab fips
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd - _b[crop_acd]*crop_acred -_b[neond]*total_neond -_b[develop_acred]*develop_acred  -_b[lag_pcpn12d]*lag_pcpn12d-_b[pcpn1d]*pcpn1d-_b[pcpn4d]*pcpn4d-_b[pcpn5d]*pcpn5d-_b[pcpn6d]*pcpn6d-_b[lag_mtemp12d]*lag_mtemp12d-_b[mtemp1d]*mtemp1d-_b[mtemp4d]*mtemp4d-_b[mtemp5d]*mtemp5d-_b[mtemp6d]*mtemp6d -_b[pop_dend]*pop_dend)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V,dof(`dof')
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conley.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"
  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}




********************************************************************
***Non-insectivorous birds

foreach x in sum_ninsect_no   ninspnumber  sum_shannonnin  {
use  non-insectivorous_birds_county, clear


drop if total_neon==. | total_neon==0


xtset fips year


***FE-IV regression
xtivreg2  `x' develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (crop_acre  total_neon  = lag_fertp pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in crop_acre  total_neon develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conley.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort fips: drop if _N==1

qui xtreg crop_acre  lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict crop_ac, xb


qui xtreg total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' crop_ac neon crop_acre total_neon lag_fertp pest_price develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den {

 egen double `j'bar = mean(`j'), by(fips)
 gen `j'd = `j'-`j'bar
  drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd crop_acd neond develop_acred lag_mtemp12d mtemp1d mtemp4d mtemp5d mtemp6d lag_pcpn12d pcpn1d pcpn4d pcpn5d pcpn6d  pop_dend , lat(lat) lon(lon) t(year) p(fips) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab fips
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd - _b[crop_acd]*crop_acred -_b[neond]*total_neond -_b[develop_acred]*develop_acred  -_b[lag_pcpn12d]*lag_pcpn12d-_b[pcpn1d]*pcpn1d-_b[pcpn4d]*pcpn4d-_b[pcpn5d]*pcpn5d-_b[pcpn6d]*pcpn6d-_b[lag_mtemp12d]*lag_mtemp12d-_b[mtemp1d]*mtemp1d-_b[mtemp4d]*mtemp4d-_b[mtemp5d]*mtemp5d-_b[mtemp6d]*mtemp6d -_b[pop_dend]*pop_dend)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V,dof(`dof')
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conley.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"
  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}




****************************************************************************
***Table S6-S7 just replace variable "total_neon" with "total_neon_most"
****************************************************************************




****************************************************************************
***Table S9
****************************************************************************
**grassland birds
*create variable list
 global var_crd crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd
 global listgcrd  sum_crd_grass crd_spnumber crd_shannon
 global list2crd  total_neoncrd crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd
 
 
***gassland bird
foreach x in sum_crd_grass crd_spnumber crd_shannon {
use  grassland_birds_CRD, clear

drop if total_neoncrd==. | total_neoncrd==0


xtset crd year


***FE-IV regression
xtivreg2  `x' $var_crd ( total_neoncrd  = pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in $list2crd  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort crd: drop if _N==1


qui xtreg total_neoncrd pest_price $var_crd ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' neon total_neoncrd $var_crd {

 egen double `j'cbar = mean(`j'), by(crd)
 gen `j'd = `j'-`j'cbar
 * drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd  neond crop_acrecrdd develop_acrecrdd lag_mtemp12crdd mtemp1crdd mtemp4crdd mtemp5crdd mtemp6crdd lag_pcpn12crdd pcpn1crdd pcpn4crdd pcpn5crdd pcpn6crdd  pop_dencrdd , lat(lat) lon(lon) t(year) p(crd) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab crd
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd  -_b[neond]*total_neoncrdd - _b[crop_acrecrdd]*crop_acrecrdd -_b[develop_acrecrdd]*develop_acrecrdd  -_b[lag_pcpn12crdd]*lag_pcpn12crdd-_b[pcpn1crdd]*pcpn1crdd-_b[pcpn4crdd]*pcpn4crdd-_b[pcpn5crdd]*pcpn5crdd-_b[pcpn6crdd]*pcpn6crdd-_b[lag_mtemp12crdd]*lag_mtemp12crdd-_b[mtemp1crdd]*mtemp1crdd-_b[mtemp4crdd]*mtemp4crdd-_b[mtemp5crdd]*mtemp5crdd-_b[mtemp6crdd]*mtemp6crdd -_b[pop_dencrdd]*pop_dencrdd)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V
 ereturn display
 
 *organize Conley Standard error results in a spreadsheet
 putexcel set "bird_Conleycrd.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"

  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se 
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}



***********************************************************************
**Non-grassland birds 
*create variable list
 global var_crd crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd
 global listgcrd  sum_crd_grass crd_spnumber crd_shannon
 global list2crd  total_neoncrd crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd
 
 
foreach x in  crd_ngrspnumber  sum_crd_nongrs  crd_ngrshannon {
use  non-grassland_birds_CRD, clear
 

drop if total_neoncrd==. | total_neoncrd==0


xtset crd year


***FE-IV regression
xtivreg2  `x' $var_crd ( total_neoncrd  = pest_price  ), fe robust 


**organize FE-IV results
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in $list2crd  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort crd: drop if _N==1


qui xtreg total_neoncrd pest_price $var_crd ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' neon total_neoncrd $var_crd {

 egen double `j'cbar = mean(`j'), by(crd)
 gen `j'd = `j'-`j'cbar
 * drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd  neond crop_acrecrdd develop_acrecrdd lag_mtemp12crdd mtemp1crdd mtemp4crdd mtemp5crdd mtemp6crdd lag_pcpn12crdd pcpn1crdd pcpn4crdd pcpn5crdd pcpn6crdd  pop_dencrdd , lat(lat) lon(lon) t(year) p(crd) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab crd
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd  -_b[neond]*total_neoncrdd - _b[crop_acrecrdd]*crop_acrecrdd -_b[develop_acrecrdd]*develop_acrecrdd  -_b[lag_pcpn12crdd]*lag_pcpn12crdd-_b[pcpn1crdd]*pcpn1crdd-_b[pcpn4crdd]*pcpn4crdd-_b[pcpn5crdd]*pcpn5crdd-_b[pcpn6crdd]*pcpn6crdd-_b[lag_mtemp12crdd]*lag_mtemp12crdd-_b[mtemp1crdd]*mtemp1crdd-_b[mtemp4crdd]*mtemp4crdd-_b[mtemp5crdd]*mtemp5crdd-_b[mtemp6crdd]*mtemp6crdd -_b[pop_dencrdd]*pop_dencrdd)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conleycrd.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"
  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}



*****************************************************************************
****Table S10
****************************************************************************
***insectivorous birds

*create variable list
 global var_crd crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd
 global listgcrd  sum_crd_grass crd_spnumber crd_shannon
 global list2crd  total_neoncrd crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd
 

foreach x in sum_crd_insect crd_inspnumber crd_inshannon {
use  insectivorous_birds_CRD, clear
     


drop if total_neoncrd==. | total_neoncrd==0


xtset crd year


***FE-IV regression
xtivreg2  `x' $var_crd ( total_neoncrd  = pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in $list2crd  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se 
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort crd: drop if _N==1


qui xtreg total_neoncrd pest_price $var_crd ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' neon total_neoncrd $var_crd {

 egen double `j'cbar = mean(`j'), by(crd)
 gen `j'd = `j'-`j'cbar
 * drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd  neond crop_acrecrdd develop_acrecrdd lag_mtemp12crdd mtemp1crdd mtemp4crdd mtemp5crdd mtemp6crdd lag_pcpn12crdd pcpn1crdd pcpn4crdd pcpn5crdd pcpn6crdd  pop_dencrdd , lat(lat) lon(lon) t(year) p(crd) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab crd
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd  -_b[neond]*total_neoncrdd - _b[crop_acrecrdd]*crop_acrecrdd -_b[develop_acrecrdd]*develop_acrecrdd  -_b[lag_pcpn12crdd]*lag_pcpn12crdd-_b[pcpn1crdd]*pcpn1crdd-_b[pcpn4crdd]*pcpn4crdd-_b[pcpn5crdd]*pcpn5crdd-_b[pcpn6crdd]*pcpn6crdd-_b[lag_mtemp12crdd]*lag_mtemp12crdd-_b[mtemp1crdd]*mtemp1crdd-_b[mtemp4crdd]*mtemp4crdd-_b[mtemp5crdd]*mtemp5crdd-_b[mtemp6crdd]*mtemp6crdd -_b[pop_dencrdd]*pop_dencrdd)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conleycrd.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"

  
mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se
} 

 putexcel D2=matrix(e(b)') E2=matrix(se)

}




**********************************************************************
***Non-insectivorous bird
   
foreach x in sum_crd_nonins   crd_ninspnumber  crd_ninshannon  {
use  noninsectivorous_birds_CRD, clear


drop if total_neoncrd==. | total_neoncrd==0


xtset crd year


***FE-IV regression
xtivreg2  `x' $var_crd ( total_neoncrd  = pest_price  ), fe robust 


**organize FE-IV results in a spreadsheet
 mat b_IV= e(b)'
 mat V_IV= e(V)

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel A1="`x'"
 local i=2
foreach var in $list2crd  {
putexcel A`i'=("`var'") 
local ++i
}

 putexcel set "bird_Conleycrd.xls", sheet("`x'") modify
 putexcel B1="Coef."
 putexcel C1="FE-IV Std.err"
 
 mat IV_se=J( 14,  14,.) 
 forval i=1/14 {
   mat IV_se[`i',1]=sqrt(V_IV[`i',`i']) // convert the variances into the se 
} 
 putexcel B2=matrix(b_IV)
 putexcel C2=matrix(IV_se)



**Calculate Conley Standard Errors (Spatial HAC)
 
 *obtain first stage results
bysort crd: drop if _N==1


qui xtreg total_neoncrd pest_price $var_crd ,fe
predict neon, xb


 *demean all the variables
foreach j in `x' neon total_neoncrd $var_crd {

 egen double `j'cbar = mean(`j'), by(crd)
 gen `j'd = `j'-`j'cbar
 * drop if `j'd==.
 }
 
 

 *run the second stage using ols_spatial_HAC to calculate the spatial HAC errors
qui ols_spatial_HAC `x'd  neond crop_acrecrdd develop_acrecrdd lag_mtemp12crdd mtemp1crdd mtemp4crdd mtemp5crdd mtemp6crdd lag_pcpn12crdd pcpn1crdd pcpn4crdd pcpn5crdd pcpn6crdd  pop_dencrdd , lat(lat) lon(lon) t(year) p(crd) dist(40) lag(0)
 *first adjust degree of freedom because of the demeaning
 qui tab crd
 local df=r(r)-1
 display `df'
 scalar df=`df'
 mat b=e(b)
 scalar vadj=df_r_old /(n_obs-1-(df_m_old+df))
 matrix V=vadj*e(V)
 ereturn post b V
 
 
 *then adjust the standard error after manual 2SLS
 local dof=e(df_r)
 matrix V_sp=e(V)


 matrix xx_1=vadj* V_sp/(rmse_old^2)

 gen double eps2_40=(`x'd  -_b[neond]*total_neoncrdd - _b[crop_acrecrdd]*crop_acrecrdd -_b[develop_acrecrdd]*develop_acrecrdd  -_b[lag_pcpn12crdd]*lag_pcpn12crdd-_b[pcpn1crdd]*pcpn1crdd-_b[pcpn4crdd]*pcpn4crdd-_b[pcpn5crdd]*pcpn5crdd-_b[pcpn6crdd]*pcpn6crdd-_b[lag_mtemp12crdd]*lag_mtemp12crdd-_b[mtemp1crdd]*mtemp1crdd-_b[mtemp4crdd]*mtemp4crdd-_b[mtemp5crdd]*mtemp5crdd-_b[mtemp6crdd]*mtemp6crdd -_b[pop_dencrdd]*pop_dencrdd)^2
 
 qui su eps2_40,meanonly
 scalar sigsq_hat =r(sum)/(n_obs-1-(df_m_old+df))
 matrix V=sigsq_hat*xx_1


 matrix bb=e(b)
 ereturn post bb V
 ereturn display
 
 *organize Conley Standard error results in the spreadsheet
 putexcel set "bird_Conleycrd.xls", sheet(`x') modify
 
 putexcel D1="Coef."
 putexcel E1="Conley Std.err"

mat se=J( df_m_old,  df_m_old,.) 
 forval i=1/14 {
   mat se[`i',1]=sqrt(sigsq_hat*xx_1[`i',`i']) // convert the variances into the se 

 putexcel D2=matrix(e(b)') E2=matrix(se)
 

}
