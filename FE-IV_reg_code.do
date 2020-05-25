*******************************************************************************
******"Neonicotinoids and Decline in Bird Biodiversity in the United States"
****** Authors: Yijia Li, Madhu Khanna and Ruiqing Miao


/*Note: This do-file is for replicating the regression results presented in the supplementary information.
We used Stata 15.0 for regression analysis.
Data and code should be downloaded and saved in the same folder.
This do-file only includes the code without sptatial autocorrelatio correction.
To calculate the spatial robust standard errors, please use the "bird_conley_code.do" file and follow the instructions.
To access "bird_conley_code.do" and any updates in the code and data, please go to
https://github.com/jewelli/Neonics-birds.git
*/
*******************************************************************************

cd "C:\Users\yijiali4\Box Sync\Backup\Biodiversity\NATSUSTAIN-19114702_data_code_forsubmission"

****************************************************************************
***Table S4
****************************************************************************
use  grassland_birds_county.dta, clear


drop if total_neon==. | total_neon==0


xtset fips year


***********bird population
xtivreg2 sum_grass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp ), fe robust 

***********species richness
xtivreg2  spnumber  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  sum_shannon develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp), fe robust



***Non-grassland birds
use  non-grassland_birds_county.dta, clear


drop if total_neon==. | total_neon==0


xtset fips year


*bird population
xtivreg2  sum_ngrass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  ngrspnumber develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  ( total_neon crop_acre = pest_price lag_fertp), fe robust

*Shannon's Index
xtivreg2  sum_shannonngr develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp ), fe robust 



****************************************************************************
***Table S5
****************************************************************************
*****insectivorous birds
use  insectivorous_birds_county, clear
	 
	 
drop if total_neon==. | total_neon==0


xtset fips year


*bird population
xtivreg2 sum_insect_no  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (  total_neon crop_acre =  pest_price lag_fertp ), fe robust 


*species richness
xtivreg2  insspnumber  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (  total_neon crop_acre = pest_price lag_fertp ), fe robust


*Shannon's Index
xtivreg2  inssum_shannon  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den (  total_neon crop_acre = pest_price lag_fertp ), fe robust 



*****non-insectivorous birds
use  non-insectivorous_birds_county.dta, clear


drop if total_neon==. | total_neon==0


xtset fips year


*bird population
xtivreg2  sum_ninsect_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp ), fe robust 


*species richness
xtivreg2  ninspnumber  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  ( total_neon crop_acre = pest_price lag_fertp ), fe robust 


*Shannon's Index
xtivreg2  sum_shannonnin develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon crop_acre = pest_price lag_fertp ), fe robust 



****************************************************************************
***Table S6 
****************************************************************************
*****grassland birds
use  grassland_birds_county, clear

drop if total_neon_most ==. | total_neon_most ==0


xtset fips year


*bird population
xtivreg2  sum_grass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 


*species richness
xtivreg2  spnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den  ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 


*Shannon's Index
xtivreg2  sum_shannon develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 


*****non-grassland birds
use  non-grassland_birds_county.dta, clear

drop if total_neon_most ==. | total_neon_most ==0


xtset fips year


*bird population
xtivreg2  sum_ngrass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 


*species richness
xtivreg2  ngrspnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 


*Shannon's Index
xtivreg2  sum_shannonngr develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 



****************************************************************************
***Table S7
****************************************************************************
*****insectivorous birds
use  insectivorous_birds_county, clear
	 
drop if total_neon_most ==. | total_neon_most ==0


xtset fips year


*bird population
xtivreg2 sum_insect_no  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  insspnumber  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  inssum_shannon  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 


***Non-insectivorous birds

use  non-insectivorous_birds_county, clear

drop if total_neon_most ==. | total_neon_most ==0


xtset fips year

*bird population
xtivreg2  sum_ninsect_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  ninspnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den  ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  sum_shannonnin develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( total_neon_most   crop_acre =  pest_price lag_fertp ), fe robust 






****************************************************************************
****Table S9
****************************************************************************
***grassland birds
use grassland_birds_CRD, clear

drop if total_neoncrd==. | total_neoncrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_grass crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst

*species richness
xtivreg2  crd_spnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd = pest_price ), fe robust savefirst

*Shannon's Index
xtivreg2  crd_shannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst



***non-grassland birds
use non-grassland_birds_CRD.dta,clear

drop if total_neoncrd==. | total_neoncrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_nongrs  crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd = pest_price ), fe robust savefirst

*species richness
xtivreg2  crd_ngrspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst

*Shannon's Index
xtivreg2  crd_ngrshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst



*****************************************************************************
****Table S10
****************************************************************************
***insectivorous birds
use  insectivorous_birds_CRD, clear

drop if  total_neoncrd==. | total_neoncrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_insect crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst

*species richness
xtivreg2  crd_inspnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd = pest_price ), fe robust savefirst

*Shannon's Index
xtivreg2  crd_inshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst


***Non-insectivorous bird
use non-insectivorous_birds_CRD.dta, clear

drop if total_neoncrd==. | total_neoncrd==0

xtset crd year

 
*bird population
xtivreg2  sum_crd_nonins crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd = pest_price ), fe robust savefirst

*species richness
xtivreg2  crd_ninspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst

*Shannon's Index
xtivreg2  crd_ninshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neoncrd =  pest_price ), fe robust savefirst



****************************************************************************
***Table S11 
****************************************************************************
***grassland birds
use grassland_birds_CRD, clear

drop if non_neoncrd==. | non_neoncrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_grass crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_spnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_shannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust


***non-grassland birds
use non-grassland_birds_CRD.dta,clear

drop if non_neoncrd==. | non_neoncrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_nongrs  crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_ngrspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_ngrshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust



****************************************************************************
***Table S12 
****************************************************************************
***insectivorous birds
use  insectivorous_birds_CRD, clear

drop if  non_neoncrd==. | non_neoncrd==0


xtset crd year


*not IV for cropland
*bird population
xtivreg2  sum_crd_insect crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_inspnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_inshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust


***Non-insectivorous bird
use  non-insectivorous_birds_CRD.dta, clear

drop if non_neoncrd==. | non_neoncrd==0


xtset crd year


*bird population
xtivreg2  sum_crd_nonins crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_ninspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_ninshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( non_neoncrd  = pest_price  ), fe robust



****************************************************************************
***Table S13
**************************************************************************** 
***grassland birds
use grassland_birds_CRD, clear

drop if epestcrd==. | epestcrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_grass crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( epestcrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_spnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_shannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust



***non-grassland birds
use non-grassland_birds_CRD.dta,clear

drop if epestcrd==. | epestcrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_nongrs  crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_ngrspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_ngrshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust



****************************************************************************
***Table S14 
****************************************************************************
***insectivorous birds
use  insectivorous_birds_CRD, clear

drop if epestcrd==. | epestcrd==0


xtset crd year


*bird population
xtivreg2  sum_crd_insect crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_inspnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_inshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd (  epestcrd  = pest_price  ), fe robust


***Non-insectivorous bird
use non-insectivorous_birds_CRD.dta, clear


drop if epestcrd==. | epestcrd==0


xtset crd year


*bird population
xtivreg2  sum_crd_nonins crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( epestcrd  = pest_price  ), fe robust

*species richness
xtivreg2  crd_ninspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( epestcrd  = pest_price  ), fe robust

*Shannon's Index
xtivreg2  crd_ninshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( epestcrd  = pest_price  ), fe robust



****************************************************************************
***Table S15 
****************************************************************************
***grassland birds
use grassland_bird_crd_sample, clear

drop if total_neon_mostcrd==. | total_neon_mostcrd==0

xtset crd year


*bird population
xtivreg2  sum_crd_grass crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*species richness
xtivreg2  crd_spnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*Shannon's Index
xtivreg2  crd_shannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 



***non-grassland birds
use non-grassland_birds_CRD.dta,clear


drop if total_neon_mostcrd==. | total_neon_mostcrd==0


xtset crd year


*bird population
xtivreg2  sum_crd_nongrs  crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*species richness
xtivreg2  crd_ngrspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*Shannon's Index
xtivreg2  crd_ngrshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 



****************************************************************************
***Table S16 
****************************************************************************
***insectivorous birds
use  insectivorous_birds_CRD, clear


drop if total_neon_mostcrd ==. | total_neon_mostcrd ==0


xtset crd year


*bird population
xtivreg2  sum_crd_insect crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*species richness
xtivreg2  crd_inspnumber crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*Shannon's Index
xtivreg2  crd_inshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 



***Non-insectivorous bird
use  non-insectivorous_birds_CRD, clear


drop if total_neon_mostcrd ==. | total_neon_mostcrd ==0


xtset crd year


*bird population
xtivreg2  sum_crd_nonins crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*species richness
xtivreg2  crd_ninspnumber  crop_acrecrd  develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd ( total_neon_mostcrd  = pest_price  ), fe robust 

*Shannon's Index
xtivreg2  crd_ninshannon crop_acrecrd develop_acrecrd lag_mtemp12crd mtemp1crd mtemp4crd mtemp5crd mtemp6crd lag_pcpn12crd pcpn1crd pcpn4crd pcpn5crd pcpn6crd  pop_dencrd  ( total_neon_mostcrd  = pest_price  ), fe robust 




****************************************************************************
***Table S17
****************************************************************************
***grassland bird
use grassland_birds_county,clear
drop if total_neon==. | total_neon==0

xtset fips year
gen state = floor(fips/1000) 

*transformed variables for endogenous models

egen mean_lag_pcpn12 = mean(lag_pcpn12)
egen mean_pcpn1 = mean(pcpn1)
egen mean_pcpn4 = mean(pcpn4)
egen mean_pcpn5 = mean(pcpn5)
egen mean_pcpn6 = mean(pcpn6)

egen mean_lag_mtemp12 = mean(lag_mtemp12)
egen mean_mtemp1 = mean(mtemp1)
egen mean_mtemp4 = mean(mtemp4)
egen mean_mtemp5 = mean(mtemp5)
egen mean_mtemp6 = mean(mtemp6)

egen mean_pop_den = mean(pop_den)
egen mean_crop_acre = mean(crop_acre)
egen mean_total_neon = mean(total_neon)
egen mean_lag_fertp = mean(lag_fertp)
egen mean_pest_price = mean(pest_price)
egen mean_develop_acre = mean(develop_acre)

gen lag_pcpn12_trans = lag_pcpn12 - mean_lag_pcpn12
gen pcpn1_trans = pcpn1 - mean_pcpn1
gen pcpn4_trans = pcpn4 - mean_pcpn4
gen pcpn5_trans = pcpn5 - mean_pcpn5
gen pcpn6_trans = pcpn6 - mean_pcpn6 

gen pop_den_trans = pop_den - mean_pop_den
gen crop_acre_trans =  crop_acre -  mean_crop_acre
gen total_neon_trans = total_neon - mean_total_neon
gen lag_fertp_trans = lag_fertp - mean_lag_fertp
gen pest_price_trans = pest_price - mean_pest_price
gen develop_acre_trans = develop_acre - mean_develop_acre

gen lag_mtemp12_trans = lag_mtemp12 - mean_lag_mtemp12
gen mtemp1_trans = mtemp1 - mean_mtemp1
gen mtemp4_trans = mtemp4 - mean_mtemp4
gen mtemp5_trans = mtemp5 - mean_mtemp5
gen mtemp6_trans = mtemp6 - mean_mtemp6

	
	
***using log transformation
gen log_develop_acre = ln(develop_acre)
gen log_crop_acre = ln(crop_acre)	
gen log_total_neon = ln(total_neon)
gen log_pop_den = ln(pop_den)
gen log_lag_fertp = ln(lag_fertp)
gen log_pest_price = ln(pest_price)

		
gen lag_pcpn12_a = lag_pcpn12
gen pcpn1_a = pcpn1
gen pcpn4_a = pcpn4
gen pcpn5_a = pcpn5
gen pcpn6_a = pcpn6

***log precipitation after add 0.00001 to zeros

replace lag_pcpn12_a = 0.00001 if lag_pcpn12_a  == 0
replace pcpn1_a = 0.00001 if pcpn1_a == 0
replace pcpn4_a = 0.00001 if pcpn4_a == 0
replace pcpn5_a = 0.00001 if pcpn5_a == 0
replace pcpn6_a = 0.00001 if pcpn6_a == 0

gen log_lag_pcpn12 = ln(lag_pcpn12_a)
gen log_pcpn1 = ln(pcpn1_a)
gen log_pcpn4 = ln(pcpn4_a)
gen log_pcpn5 = ln(pcpn5_a)
gen log_pcpn6 = ln(pcpn6_a)
		

		

***Run GMM endogenous Poisson models 
program gmm_poiendo
   version 14
   syntax varlist if, at(name) myrhs(varlist) ///
   mylhs(varlist) myidvar(varlist)
   quietly {
   tempvar mu mubar ybar
   gen double `mu' = 0 `if'
   local j = 1
   foreach var of varlist `myrhs' {
      replace `mu' = `mu' + `var'*`at'[1,`j'] `if'
      local j = `j' + 1
      }
   replace `mu' = exp(`mu')
   replace `varlist' = `mylhs'/`mu' - L.`mylhs'/L.`mu' `if'
   }
end	


			
***transform all right-hand-side variables

global xlist_trans_all total_neon_trans crop_acre_trans develop_acre_trans lag_pcpn12_trans  mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_mtemp12_trans pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans   
	
global ivlist_trans_all  lag_fertp_trans pest_price_trans develop_acre_trans lag_mtemp12_trans mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_pcpn12_trans  pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans

		
gmm gmm_poiendo, mylhs(spnumber) /// cluster on cty
	myrhs($xlist_trans_all) myidvar(fips)  nequations(1) parameters($xlist_trans_all)  ///
    instruments($ivlist_trans_all, noconstant) twostep vce(cluster fips) technique(gn) winitial(un) 

	
	
****************************************************************************	
***non-grassland bird
use non-grassland_bird_county, clear
drop if total_neon==. | total_neon==0
xtset fips year


egen mean_lag_pcpn12 = mean(lag_pcpn12)
egen mean_pcpn1 = mean(pcpn1)
egen mean_pcpn4 = mean(pcpn4)
egen mean_pcpn5 = mean(pcpn5)
egen mean_pcpn6 = mean(pcpn6)

egen mean_lag_mtemp12 = mean(lag_mtemp12)
egen mean_mtemp1 = mean(mtemp1)
egen mean_mtemp4 = mean(mtemp4)
egen mean_mtemp5 = mean(mtemp5)
egen mean_mtemp6 = mean(mtemp6)

egen mean_pop_den = mean(pop_den)
egen mean_crop_acre = mean(crop_acre)
egen mean_total_neon = mean(total_neon)
egen mean_lag_fertp = mean(lag_fertp)
egen mean_pest_price = mean(pest_price)
egen mean_develop_acre = mean(develop_acre)

gen lag_pcpn12_trans = lag_pcpn12 - mean_lag_pcpn12
gen pcpn1_trans = pcpn1 - mean_pcpn1
gen pcpn4_trans = pcpn4 - mean_pcpn4
gen pcpn5_trans = pcpn5 - mean_pcpn5
gen pcpn6_trans = pcpn6 - mean_pcpn6 

gen pop_den_trans = pop_den - mean_pop_den
gen crop_acre_trans =  crop_acre -  mean_crop_acre
gen total_neon_trans = total_neon - mean_total_neon
gen lag_fertp_trans = lag_fertp - mean_lag_fertp
gen pest_price_trans = pest_price - mean_pest_price
gen develop_acre_trans = develop_acre - mean_develop_acre

gen lag_mtemp12_trans = lag_mtemp12 - mean_lag_mtemp12
gen mtemp1_trans = mtemp1 - mean_mtemp1
gen mtemp4_trans = mtemp4 - mean_mtemp4
gen mtemp5_trans = mtemp5 - mean_mtemp5
gen mtemp6_trans = mtemp6 - mean_mtemp6




***Run GMM endogenous Poisson models 

program gmm_poiendo
   version 14
   syntax varlist if, at(name) myrhs(varlist) ///
   mylhs(varlist) myidvar(varlist)
   quietly {
   tempvar mu mubar ybar
   gen double `mu' = 0 `if'
   local j = 1
   foreach var of varlist `myrhs' {
      replace `mu' = `mu' + `var'*`at'[1,`j'] `if'
      local j = `j' + 1
      }
   replace `mu' = exp(`mu')
   replace `varlist' = `mylhs'/`mu' - L.`mylhs'/L.`mu' `if'
   }
end	


***transform all right-hand-side variables

global xlist_trans_all total_neon_trans crop_acre_trans develop_acre_trans lag_pcpn12_trans  mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_mtemp12_trans pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans   
	
global ivlist_trans_all  lag_fertp_trans pest_price_trans develop_acre_trans lag_mtemp12_trans mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_pcpn12_trans  pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans
		
gmm gmm_poiendo, mylhs(ngrspnumber) /// cluster on cty
	myrhs($xlist_trans_all) myidvar(fips)  nequations(1) parameters($xlist_trans_all)  ///
    instruments($ivlist_trans_all, noconstant) twostep vce(cluster fips) technique(nr) winitial(un) 
	
	
	
****************************************************************************	
***insectivorous bird
use insectivorous_birds_county,clear
drop if total_neon==. | total_neon==0
xtset fips year


egen mean_lag_pcpn12 = mean(lag_pcpn12)
egen mean_pcpn1 = mean(pcpn1)
egen mean_pcpn4 = mean(pcpn4)
egen mean_pcpn5 = mean(pcpn5)
egen mean_pcpn6 = mean(pcpn6)

egen mean_lag_mtemp12 = mean(lag_mtemp12)
egen mean_mtemp1 = mean(mtemp1)
egen mean_mtemp4 = mean(mtemp4)
egen mean_mtemp5 = mean(mtemp5)
egen mean_mtemp6 = mean(mtemp6)

egen mean_pop_den = mean(pop_den)
egen mean_crop_acre = mean(crop_acre)
egen mean_total_neon = mean(total_neon)
egen mean_lag_fertp = mean(lag_fertp)
egen mean_pest_price = mean(pest_price)
egen mean_develop_acre = mean(develop_acre)

gen lag_pcpn12_trans = lag_pcpn12 - mean_lag_pcpn12
gen pcpn1_trans = pcpn1 - mean_pcpn1
gen pcpn4_trans = pcpn4 - mean_pcpn4
gen pcpn5_trans = pcpn5 - mean_pcpn5
gen pcpn6_trans = pcpn6 - mean_pcpn6 

gen pop_den_trans = pop_den - mean_pop_den
gen crop_acre_trans =  crop_acre -  mean_crop_acre
gen total_neon_trans = total_neon - mean_total_neon
gen lag_fertp_trans = lag_fertp - mean_lag_fertp
gen pest_price_trans = pest_price - mean_pest_price
gen develop_acre_trans = develop_acre - mean_develop_acre

gen lag_mtemp12_trans = lag_mtemp12 - mean_lag_mtemp12
gen mtemp1_trans = mtemp1 - mean_mtemp1
gen mtemp4_trans = mtemp4 - mean_mtemp4
gen mtemp5_trans = mtemp5 - mean_mtemp5
gen mtemp6_trans = mtemp6 - mean_mtemp6




***Run GMM endogenous Poisson models 

program gmm_poiendo
   version 14
   syntax varlist if, at(name) myrhs(varlist) ///
   mylhs(varlist) myidvar(varlist)
   quietly {
   tempvar mu mubar ybar
   gen double `mu' = 0 `if'
   local j = 1
   foreach var of varlist `myrhs' {
      replace `mu' = `mu' + `var'*`at'[1,`j'] `if'
      local j = `j' + 1
      }
   replace `mu' = exp(`mu')
   replace `varlist' = `mylhs'/`mu' - L.`mylhs'/L.`mu' `if'
   }
end	


***transform all right-hand-side variables
global xlist_trans_all total_neon_trans crop_acre_trans develop_acre_trans lag_pcpn12_trans  mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_mtemp12_trans pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans   
	
global ivlist_trans_all  lag_fertp_trans pest_price_trans develop_acre_trans lag_mtemp12_trans mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_pcpn12_trans  pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans
	
gmm gmm_poiendo, mylhs(insspnumber ) /// cluster on cty
	myrhs($xlist_trans_all) myidvar(fips)  nequations(1) parameters($xlist_trans_all)  ///
    instruments($ivlist_trans_all, noconstant) twostep vce(cluster fips) technique(nr) winitial(un) 
		

		
****************************************************************************		
***non-insectivorous birds

use non-insectivorous_bird_county, clear
drop if total_neon==. | total_neon==0
xtset fips year


egen mean_lag_pcpn12 = mean(lag_pcpn12)
egen mean_pcpn1 = mean(pcpn1)
egen mean_pcpn4 = mean(pcpn4)
egen mean_pcpn5 = mean(pcpn5)
egen mean_pcpn6 = mean(pcpn6)

egen mean_lag_mtemp12 = mean(lag_mtemp12)
egen mean_mtemp1 = mean(mtemp1)
egen mean_mtemp4 = mean(mtemp4)
egen mean_mtemp5 = mean(mtemp5)
egen mean_mtemp6 = mean(mtemp6)

egen mean_pop_den = mean(pop_den)
egen mean_crop_acre = mean(crop_acre)
egen mean_total_neon = mean(total_neon)
egen mean_lag_fertp = mean(lag_fertp)
egen mean_pest_price = mean(pest_price)
egen mean_develop_acre = mean(develop_acre)

gen lag_pcpn12_trans = lag_pcpn12 - mean_lag_pcpn12
gen pcpn1_trans = pcpn1 - mean_pcpn1
gen pcpn4_trans = pcpn4 - mean_pcpn4
gen pcpn5_trans = pcpn5 - mean_pcpn5
gen pcpn6_trans = pcpn6 - mean_pcpn6 

gen pop_den_trans = pop_den - mean_pop_den
gen crop_acre_trans =  crop_acre -  mean_crop_acre
gen total_neon_trans = total_neon - mean_total_neon
gen lag_fertp_trans = lag_fertp - mean_lag_fertp
gen pest_price_trans = pest_price - mean_pest_price
gen develop_acre_trans = develop_acre - mean_develop_acre

gen lag_mtemp12_trans = lag_mtemp12 - mean_lag_mtemp12
gen mtemp1_trans = mtemp1 - mean_mtemp1
gen mtemp4_trans = mtemp4 - mean_mtemp4
gen mtemp5_trans = mtemp5 - mean_mtemp5
gen mtemp6_trans = mtemp6 - mean_mtemp6




***Run GMM endogenous Poisson models 

program gmm_poiendo
   version 14
   syntax varlist if, at(name) myrhs(varlist) ///
   mylhs(varlist) myidvar(varlist)
   quietly {
   tempvar mu mubar ybar
   gen double `mu' = 0 `if'
   local j = 1
   foreach var of varlist `myrhs' {
      replace `mu' = `mu' + `var'*`at'[1,`j'] `if'
      local j = `j' + 1
      }
   replace `mu' = exp(`mu')
   replace `varlist' = `mylhs'/`mu' - L.`mylhs'/L.`mu' `if'
   }
end	


***transform all right-hand-side variables
global xlist_trans_all total_neon_trans crop_acre_trans develop_acre_trans lag_pcpn12_trans  mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_mtemp12_trans pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans   
	
global ivlist_trans_all  lag_fertp_trans pest_price_trans develop_acre_trans lag_mtemp12_trans mtemp1_trans mtemp4_trans mtemp5_trans mtemp6_trans lag_pcpn12_trans  pcpn1_trans pcpn4_trans pcpn5_trans pcpn6_trans  pop_den_trans
	
gmm gmm_poiendo, mylhs(ninspnumber) /// cluster on cty
	myrhs($xlist_trans_all) myidvar(fips)  nequations(1) parameters($xlist_trans_all)  ///
    instruments($ivlist_trans_all, noconstant) twostep vce(cluster fips) technique(nr) winitial(un) 

	
	
	
****************************************************************************
***Table S18
****************************************************************************
*****grassland birds
use  grassland_birds_county, clear

drop if non_neon==. | non_neon==0


xtset fips year


*bird population
xtivreg2  sum_grass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  spnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( non_neon crop_acre =  pest_price lag_fertp), fe robust 

*Shannon's Index
xtivreg2  sum_shannon develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( non_neon crop_acre =  pest_price lag_fertp), fe robust 




*****non-grassland birds
use  non-grassland_birds_county.dta, clear

drop if non_neon==. | non_neon==0


xtset fips year


*bird population
xtivreg2  sum_ngrass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  ngrspnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  sum_shannonngr develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 



****************************************************************************
***Table S19 
****************************************************************************
*****insectivorous birds
use  insectivorous_birds_county, clear
	 
drop if non_neon==. | non_neon==0


xtset fips year


*bird population
xtivreg2 sum_insect_no  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  insspnumber  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  inssum_shannon  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( non_neon crop_acre =  pest_price lag_fertp ), fe robust 



***Non-insectivorous birds
use  non-insectivorous_birds_county, clear

drop if non_neon==. | non_neon==0


xtset fips year

*bird population
xtivreg2  sum_ninsect_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( non_neon crop_acre =  pest_price lag_fertp), fe robust 

*species richness
xtivreg2  ninspnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( non_neon crop_acre =  pest_price lag_fertp), fe robust 

*Shannon's Index
xtivreg2  sum_shannonnin develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( non_neon crop_acre =  pest_price lag_fertp), fe robust 




****************************************************************************
***Table S20 pesticide use
****************************************************************************
*****grassland birds
use  grassland_birds_county, clear

drop if epest ==. | epest ==0


xtset fips year


*bird population
xtivreg2  sum_grass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  spnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den  ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  sum_shannon develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 



*****non-grassland birds
use  non-grassland_birds_county, clear

drop if epest ==. | epest ==0


xtset fips year


*bird population
xtivreg2  sum_ngrass_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  ngrspnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  sum_shannonngr develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 



****************************************************************************
***Table S21 pesticide use
****************************************************************************
*****insectivorous birds
use  insectivorous_birds_county, clear
	 
drop if epest ==. | epest ==0


xtset fips year


*bird population
xtivreg2 sum_insect_no  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  insspnumber  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den  ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  inssum_shannon  develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 



***Non-insectivorous birds
use  non-insectivorous_birds_county, clear

drop if epest ==. | epest ==0


xtset fips year

*bird population
xtivreg2  sum_ninsect_no develop_acre lag_mtemp12 mtemp1 mtemp4 mtemp5 mtemp6 lag_pcpn12 pcpn1 pcpn4 pcpn5 pcpn6  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*species richness
xtivreg2  ninspnumber  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den  ( epest crop_acre =  pest_price lag_fertp ), fe robust 

*Shannon's Index
xtivreg2  sum_shannonnin develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den ( epest crop_acre =  pest_price lag_fertp ), fe robust 




****************************************************************************
***Table S22 
****************************************************************************
***grassland birds
use grassland_birds_county, clear

drop if total_neon==. | total_neon==0

xtset fips year

xtabond2 sum_grass_no L.sum_grass_no crop_acre total_neon develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, gmm(L.( sum_grass_no ),lag(1 2)) iv(lag_fertp pest_price develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, eq(diff) )  robust twostep



***non-grassland birds
use  non-grassland_birds_county, clear

drop if total_neon==. | total_neon==0

xtset fips year

xtabond2 sum_ngrass_no L.sum_ngrass_no  crop_acre total_neon develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, gmm(L.( sum_ngrass_no ),lag(1 3)) iv(lag_fertp pest_price develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, eq(diff) )  robust twostep



**insectivorous bird
use  insectivorous_birds_county, clear

drop if total_neon==. | total_neon==0

xtset fips year

xtabond2 sum_insect_no L.sum_insect_no crop_acre total_neon  develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, gmm(L.( sum_insect_no ),lag(3 4)) iv(lag_fertp pest_price develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den )  robust twostep



***non-insectivorous bird
use  non-insectivorous_birds_county, clear

drop if total_neon==. | total_neon==0

xtset fips year

xtabond2 sum_ninsect_no L.sum_ninsect_no  crop_acre total_neon develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, gmm(L.( sum_ninsect_no ),lag(1 3)) iv(lag_fertp pest_price develop_acre mtemp1 mtemp4 mtemp5 mtemp6 lag_mtemp12 pcpn1 pcpn4 pcpn5 pcpn6 lag_pcpn12  pop_den, eq(diff) )  robust twostep

