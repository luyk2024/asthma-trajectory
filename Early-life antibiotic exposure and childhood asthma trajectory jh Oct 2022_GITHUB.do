/* _____________________________________________________________________________________
 
	Title: 				Early-life antibiotic use and childhood asthma trajectories: evidence from a national population-based birth cohort
	Datasets used:		LSAC wave 1 -  "D:\Calvin\Luyk\others\abx\LSAC\General Release\Survey data\STATA\lsacgrb0.dta"
	                    PBS parent 1 - "D:\Calvin\Luyk\others\abx\LSAC\Linked Medicare data\STATA\pbsp1.dta"
	
	                 

	Date created:		Yankun Lu 25 June 2021
	Last updated:		03/07/2022, by Calvin, 30/10/2022, by Yanhong Jessika Hu 
	Stata Version:      Stata/SE 15.1
	Purpose:		    Part 1 - Cleaning drug variables and reshape dataset
	                    Part 2 - merge with other LSAC dataset containing date of birth var 
						Part 3a - Antibiotic exposure (0-24 months)
						Part 3b - Tabulating characteristics
						Part 3c - Asthma outcome at each wave
						part 4 - Trajectory & multinomial regression
						part 5 - Subgroup and restriction analyses
						
						
______________________________________________________________________________________ */

clear 
******************************************************************************

///        						Part 1										///



{/*For all antibiotics*/
use "STATA\pbschild.dta", replace 

**Keep useful variables 
keep hicid itemcode itemname quantity datesupp
save "stata\pbschild-keep.dta", replace 

encode itemname, generate(itemname_n)

tabulate itemname, gen(name)

gen drugclass = .
replace drugclass = 0 if itemname!=" "

save "stata\pbschild-keep-drugclass", replace

/*The following categories are based on TGA Category*/

1 "beta-Lactam penicillins" 

replace drugclass = 1 if name234 |name235 |name236 |name307 |name1861 |name1958 |name2241 |name1800 |name1801  |name1861 |name837 |name838 |name839 |name840 |name841 |name842 |name843 |name844 |name845 |name846 |name847 |name848 |name849 |name850 |name851 |name927 |name928 |name929 |name930 |name931 |name932 |name933 |name934|name654 |name655 |name656 |name657 |name721 |name722 |name723|name234 |name235 |name236 |name307|name179|name810| name809 |name176 |name175 |name174 |name173 |name172 |name171 |name170 |name169 |name168 |name167 |name166 |name165 |name164 |name163 |name162 |name161 |name160 |name159 |name158 |name87 |name86 |name85 |name84 |name83 |name82 |name81 |name80 |name79 |name78 |name77 |name76 |name75 |name74 |name73 |name72 |name71 |name70 |name69 |name68 |name67 |name66 |name65 |name64 |name63 |name62 |name229|name1785 |name1786 |name1787 |name1788 |name1789 |name1790 |name1791 |name1792 |name1793 |name1794 |name1795 |name1796 |name1797 |name1798 |name1799 |name1800 |name1801 |name1904 |name1905 |name1906 |name1907 |name1908 |name1909 |name1910 |name1911 |name1912 |name1913 |name1914 |name649|name650|name651|name652|name653|name716|name717|name718|name719|name720

*ticarcillin, penicillin, phenoxymethylpenicillin, procaine penicillin, flucloxacillin, dicloxacillin, benzylpenicillin, ampicillin, amoxycillin, 

--------------------------------------------------------------------------------


2 "1st-generation Cephalosporin"
replace drugclass = 2 if  name386 |name387 |name388 |name389|name390| name391 |name392|name530 |name531|name548 |name549 |name402 |name403 |name404 |name405 |name406 |name407 |name408 |name409 |name540 |name541 |name542 |name543 |name544 |name545 |name546 |name547 

 *cefalexin, cefalotin, cephazolin, 
 
--------------------------------------------------------------------------------

 
3 "2nd-generation cephalosporin"
replace drugclass = 3 if name378| name379 |name380 |name381 |name382 |name383 |name384 |name385 |name523 |name524 |name525 |name526 |name527 |name528 |name529|name397| name398 |name535 |name536 |name537
 
 
 *cefaclor, cefuroxime, 
 
--------------------------------------------------------------------------------
 
 4 "3rd-generation cephalosporin"
replace drugclass = 4 if name393 |name394 |name395 |name396 |name532 |name533 |name534
 
 
 *cefotaxime, ceftriaxone 
 
--------------------------------------------------------------------------------
 
 5 "quinolone"
replace drugclass = 5 if name436 |name437 |name438 |name440 |name442 |name570 |name571 |name572 |name574|name1588 |name1589 |name1618 |name1619

 *ciprofloxacin, norfloxacin
 
--------------------------------------------------------------------------------
 
 6 "Macrolide" 

replace drugclass = 6 if name117 |name118 |name119 |name120 |name121 |name211 |name212 |name213 |name214|name448| name449 |name450 |name451 |name452 |name453 |name579 |name580 |name581 |name582 |name809 |name810 |name1700|name760| name761 |name762 |name763 |name764 |name765 |name766 |name767 |name768 |name769 |name770 |name771 |name772 |name773 |name796 |name797 |name798 |name799 |name800 |name801 |name802 |name803 |name804 |name2036 |name2037 |name2038 |name2039 |name2040 |name2041 |name2042 |name2043 |name2044 |name2079 |name2080 |name2081 |name2082 |name2083 |name2084

 *azithromycin, clarithromycin, erythromycin, roxithromycin, 
 
--------------------------------------------------------------------------------
 
  
 7 "Tetracycline"
replace drugclass = 7 if name675 |name676 |name677 |name678 |name679 |name680 |name681 |name682 |name683 |name684 |name685 |name686 |name735 |name736 |name737 |name738 |name739 |name740 |name741 |name742 |name743 |name744 |name745 |name746 |name1404 | name1523


 *doxycycline, minocycline, 
 
--------------------------------------------------------------------------------

 
 8 "lincosamides" 

replace drugclass = 8 if name454 |name455| name583| name584
 
*clindamycin

--------------------------------------------------------------------------------

 
 9 "Aminoglycosides"  
 
 replace drugclass = 9 if name980| name982 |name2247|name2252 |name2341|name2342
 
 
*gentamycin, tobramycin, neomycin,   
 
--------------------------------------------------------------------------------

 
 10 "Sulfonamides and Trimethoprim"

 replace drugclass = 10 if name2294 |name2295 |name2296 |name2297 |name2298 |name2299 |name2300 |name2301 |name2302 |name2303 |name2304 |name2305 |name2306 |name2307 |name2372 |name2373 |name2374 |name2375 |name2376 |name2377 |name2378 |name2110 | name2177 |name2200|name2201
 
 
 *trimethoprim, sulfamethoxazole trimethoprim, silver sulfadiazine, 
 
--------------------------------------------------------------------------------
 
 
  11 " Nitroimidazole" 
 replace drugclass = 11 if name1384| name1385 |name1386 |name1387 |name1388 |name1389 |name1390 |name1391 |name1392 |name1393 |name1394 |name1395 |name1514 |name1515 |name1516 |name1517 |name1518 |name1519 |name1520| name2242|name2243|name2244| name2332| name2333
 

 *metronidazole, tinidazole, 
 
--------------------------------------------------------------------------------

 
  12 "Fusidane"
 replace drugclass = 12 if name912 | name977|name976 |name911 |name913

  
 *fusidic acid
 
--------------------------------------------------------------------------------
 
 
  13 "Nitrofuran"
  
 replace drugclass = 13 if name1580 |name1610|name1611|name1612|name1613
 

 *nitrofurantoin
-------------------------------------------------------------------------------- 
label var drugclass "drugclass"
label define drugclasslab 1 "beta-Lactam penicillins" 2 "1st-generation Cephalosporin" 3 "2nd-generation cephalosporin" 4 "3rd-generation cephalosporin" 5 "quinolone" 6 "Macrolide" 7 "Tetracycline"  8 "lincosamides" 9 "Aminoglycosides" 10 "Sulfonamides and Trimethoprim" 11 " Nitroimidazole" 12 "Fusidane" 13 "Nitrofuran"

label value drugclass drugclasslab
tab drugclass, missing

*Drop obs for non-antibiotics prescriptions
drop if drugclass==0

*Drop name* variables
drop name*

*Drop orginal item variables 
drop itemcode itemname quantity itemname_n

**Sort
sort hicid drugclass datesupp


**Create sequential number of  medications by hicid
by hicid: gen drugclass_n=_n


**Reshape pbs dataset by date supply
**Any category of antibiotics
drop drugclass
reshape wide datesupp, i(hicid) j(drugclass_n)
rename datesupp* anyantibiotics*
save "stata\pbssc.dta", replace
}


{/**Repeat the above steps to extract for each category of antibiotics! For example for 1 "Penicillin"*/
**Beta-lactam penicillin
use "pbschild-keep-drugclass", replace

				
*******************************************************************************

///								Part 2									///

//For infant antibiotic exposure, merge "pbschild-anyabx" file with "LSACgrb0" file.
use  "pbssc.dta"
merge 1:1 hicid using "lsacgrb0.dta", gen(mergepbschild)
ta mergepbschild
drop if mergepbschild == 1
summ hicid

*set exposure period between 0 - 24 months of infant age
gen date_sc_2y = zf04m1 + 365.25*2
format date_sc_2y %td
foreach var of varlist anyantibiotics* {
replace `var'=. if `var' < zf04m1
replace `var'=. if `var' > date_sc_2y  
replace `var'=1 if `var'<= date_sc_2y   & `var'>= zf04m1 
}

egen anyabxcount2=rowtotal(anyantibiotics*)
ta anyabxcount2
label var anyabxcount2 "Number of any antibiotics used birth up to 24 months of age"
drop anyantibiotics*

gen post_abx2_bin = .
replace post_abx2_bin = 0 if anyabxcount2 == 0
replace post_abx2_bin = 1 if anyabxcount2 >= 1
ta post_abx2_bin

save "lsacgrb0-pbssc.dta", replace
	
********************************************************************************
///								Part 3 A								///


*merge previous antibiotic class into lsac cohort


//merge individual datasets for any antibiotics*/

use "lsacgrb0-pbssc.dta", replace

*betalactam
merge 1:1 hicid using "D:\Calvin\Luyk\others\abx\LSAC\stata\pbschild-betalactam.dta", gen (mergebeta)
ta mergebeta
drop if mergebeta == 2

foreach var of varlist betalactam* {
replace `var'=. if `var' < zf04m1
replace `var'=. if `var' > date_sc_2y  
replace `var'=1 if `var'<= date_sc_2y   & `var'>= zf04m1 
}

egen anybetacount=rowtotal(betalactam*)
tab anybetacount
label var anybetacount "Number of Any Beta lactam penicillins used from birth up to 24 months of age"
drop betalactam*
ta anybetacount
save "lsacgrbo-pbssc-abx.dta", replace

--------------------------------------------------------------------------------
{/**Repeat the above steps to extract for each category of antibiotics!

--------------------------------------------------------------------------------

*drop unnecessary variables
drop mergefuran mergefusi mergenitro mergesulfo mergeamino mergelinco mergeglyco mergetetra1 mergemacro mergequino merge3rdgen merge2ndgen merge1stgen mergebeta mergepbschild
save "lsacb2-anyabx.dta", replace

********************************************************************************

///								Part 3 B 								///



use "lsacb2-anyabx.dta"

*what is the maternal age?
//maternalage = mum's age - sc's age 

gen maternalage = af03m2 - af03m1

label variable maternalage "maternal age"


*infant mean weight
summarize zhs03a

*birth weight

tabulate zhs03a

gen birthweight = .
replace birthweight = 0 if zhs03a <2500
replace birthweight = 1 if zhs03a >= 2500 & zhs03a < 2999
replace birthweight = 2 if zhs03a >=3000 & zhs03a < 3999
replace birthweight = 3 if zhs03a >=4000 & zhs03a < 5499
label define bwlab1 0 "<2500" 1 "2500-2999" 2 "3000-3999" 3 "4000-5499"
label value birthweight bwlab1
label var birthweight "SC's weight at birth"

ta birthweight, missing 



*child's sex

tabulate zf02m1

*type of delivery

gen deliverytype = .

replace deliverytype = 0 if zhs02a==1
replace deliverytype = 1 if zhs02b==1
replace deliverytype = 2 if zhs02c==1
replace deliverytype = 3 if zhs02d==1
replace deliverytype = 4 if zhs02e==1
replace deliverytype = 5 if zhs02f==1
label var deliverytype "Type of birth delivery"
label define deliverylab 0 "vaginal" 1 "breech" 2 "caesection" 3 "vacuum extraction" 4 "forceps" 5 "others"
label value deliverytype deliverylab


codebook zhs02a zhs02c

*socioeconomic position

acnfsda - SEIFA

xtile sep_5 = acnfsda, nq(5)

tabstat sep_5, stat(n mean min max sd p50) by (sep_5)

ta sep_5

*number of children living in household

aho07a3

gen house_child = .

replace house_child = 0 if aho07a3 == 0
replace house_child = 1 if aho07a3 == 1
replace house_child = 2 if aho07a3 == 2
replace house_child = 3 if aho07a3 == 3
replace house_child = 4 if aho07a3 >3
label var house_child "number of children living in house"
label define housechildlab 0 " 0 children" 1 "one" 2 "two " 3 "three" 4 "four or more"
label value house_child housechildlab

**generate dates for pregnancy period

gen pregstart_date= zf04m1 - zhs04a*7 if zhs04a>0
format pregstart_date %td
tab pregstart_date

gen start = pregstart_date
gen end = zf04m1
gen pregperiod = end - start + 1 
label variable pregperiod "gestation_days"

**make days into weeks

gen pregperiod_wks = pregperiod/7

label variable pregperiod_wks "gestation_weeks"

tabstat pregperiod_wks

*Gestational weeks

summarize pregperiod_wks

*preterm birth

//set criteria for preterm birth in terms of gestational weeks

gen preterm_cat = .
replace preterm_cat = 0 if pregperiod_wks > 37
replace preterm_cat = 1 if pregperiod_wks < 28
replace preterm_cat = 2 if pregperiod_wks >=28 & pregperiod_wks < 32
replace preterm_cat = 3 if pregperiod_wks >= 32 & pregperiod_wks < 37
label var preterm_cat "Preterm birth categories"
label define preterm_catlab 0 "Normal" 1 "extremely preterm" 2 "very preterm" 3 "moderate to late preterm"
label value preterm_cat preterm_catlab

*low birthweight

gen lowbw_bin = .
replace lowbw_bin = 1 if birthweight == 0
replace lowbw_bin = 0 if birthweight >= 1
label var lowbw_bin "low birthweight (binary)"
label define lowbw_binlab 0 "No" 1 "Yes"
label value lowbw_bin lowbw_binlab

*maternal asthma

//zhb01b - asthma medication used during pregnancy

codebook zhb01b

generate maternalas_bin = .
replace maternalas_bin = 0 if zhb01b == 0
replace maternalas_bin = 1 if zhb01b ==1
label var maternalas_bin "Did mother use asthma medication during pregnancy? binary" 
label define maternalas_binlab 0 "no" 1 "yes"
label value maternalas_bin maternalas_binlab

*maternal smoking

codebook zhb18a2

gen maternalsmk = .
replace maternalsmk = 1 if zhb18a2 ==1
replace maternalsmk = 0 if zhb18a2 == 2
label var maternalsmk "Maternal smoking during pregnancy"
label define maternalsmklab1 1 "Yes" 0 "No"
label value maternalsmk maternalsmklab1

*maternal alcohol

codebook zhb17a2

generate maternalal = .
replace maternalal = 1 if zhb17a2 == 1
replace maternalal = 0 if zhb17a2 == 2
label var maternalal "Maternal alcohol consumption during pregnancy"
label define maternalallab1 1 "yes" 0 "no"
label value maternalal maternalallab1

*rurality

codebook asos

gen rurality = .
replace rurality = 0 if asos < 3 
replace rurality = 1 if asos ==3
label var rurality "geographical location"
label define ruralitylab 0 "urban" 1 "rural"
label value rurality ruralitylab


*Exclusive breastfeeding

gen formula = .
replace formula = 0 if zhb07 >0 & zhb07 <180
replace formula = 1 if zhb07 >=180
label var formula "Usage of formula-led feeding"
label define formulalab1 0 "formula under 180 days" 1 "formula after 180 days"
label value formula formulalab1

ta formula 

*Ethnicity
/*mother+father birth country: zf09am zf09af*/
/*mother's birth country*/

gen mother_country=1 if zf09am==1101
replace mother_country=2 if zf09am==4215 | zf09am==5101 | zf09am==5102 | zf09am==5104 | zf09am==5105 | zf09am==5202 | zf09am==5203 ///
| zf09am==5204 | zf09am==5205 | zf09am==6100 | zf09am==6102 | zf09am==6201 | zf09am==7101 | zf09am==7103 | zf09am==7106  ///
| zf09am==7107 | zf09am==7201 | zf09am== 4203 | zf09am==4204 | zf09am==4205 | zf09am== 4208
replace mother_country=3 if zf09am== 2100 | zf09am==2105 | zf09am==2201 | zf09am== 2303 | zf09am==2304 | zf09am==2311 | zf09am==3106 ///
| zf09am==3213 | zf09am==3307 | zf09am== 3308
replace mother_country=4 if mother_country==. & zf09am !=.
label var mother_country "mother's country"
label define mother_country_lbl 1 "Australia" 2 "Asia"  3 "UK/Europe" 4"other"
label values mother_country mother_country_lbl
codebook mother_country

/*Father's birth country*/
gen father_country=1 if zf09af==1101
replace father_country=2 if zf09af==4215 | zf09af==5101 | zf09af==5102 | zf09af==5104 | zf09af==5105 | zf09af==5202 | zf09af==5203 ///
| zf09af==5204 | zf09af==5205 | zf09af==6100 | zf09af==6102 | zf09af==6201 | zf09af==7101 | zf09af==7103 | zf09af==7106  ///
| zf09af==7107 | zf09af==7201 | zf09af== 4203 | zf09af==4204 | zf09af==4205 | zf09af== 4208
replace father_country=3 if zf09af== 2100 | zf09af==2105 | zf09af==2201 | zf09af== 2303 | zf09af==2304 | zf09af==2311 | zf09af==3106 ///
| zf09af==3213 | zf09af==3307 | zf09af== 3308
replace father_country=4 if father_country==. & zf09af !=.
label var father_country "father's country"
label define father_country_lbl 1 "Australia" 2 "Asia"  3 "UK/Europe" 4"other"
label values father_country father_country_lbl
codebook father_country
 
gen cethnicity=1 if mother_country==1 & father_country==1
replace cethnicity=2 if mother_country!=1 | father_country!=1
label define cethnicity_1 1 "Australia" 2 "Non-Australia"
label values cethnicity cethnicity_1
label var cethnicity "Ethnicity"

///


*maternal education
codebook afd08a1

gen maternaled = .
replace maternaled = 0 if afd08a1 >1
replace maternaled = 1 if afd08a1 == 1
replace maternaled = 2 if afd08a3a == 5 | afd08a3a ==4 | afd08a3a == 3
replace maternaled = 3 if afd08a3a == 2 | afd08a3a == 1

label var maternaled "Maternal education"
label define maternaledlab4 0 "< year 12 education" 1 "Completed year 12" 2 "Bachelor degree, advanced diploma, diploma or certificate" 3 "Postgraduate degree, graduate diploma or certificate" 
label value maternaled maternaledlab4


*Maternal antibiotic - any antibiotic use during pregnancy (Yes/No)
ta zhb01a

save "lsacb2-anyabx.dta", replace

*presence of older sibling at home at age 2

use "lsacgrb2.dta"
keep hicid bosib
save "lsacgrb2-sibling-keep.dta", replace


merge 1:1 hicid using "D:\Calvin\Luyk\others\abx\LSAC\stata\lsacb2-anyabx.dta", gen(merge_lsacgrb2sib)
tab merge_lsacgrb2sib 
drop merge_lsacgrb2sib
save "lsacb2-anyabx.dta", replace

	  
//Ever been hospitalized for fever or respiratory infections at age 2

*wave 2

use "lsacgrb2.dta"
keep hicid bhs19b1
save "lsacgrb2-viral infection.dta", replace

merge 1:1 hicid using "lsacb2-anyabx.dta", gen(mergeviralw2)
ta mergeviralw2
drop mergeviralw2
save "lsacb2-anyabx.dta", replace 

	///number of children sleeping at home at age 2

*wave 2
use "lsacgrb2.dta"
keep hicid bhsib
save "lsacgrb2-sibling.dta", replace
merge 1:1 hicid using "lsacb2-anyabx.dta", gen (mergesib2)
summ hicid
save "lsacb2-anyabx.dta", replace 


**add labels

label var maternalage "maternal age"
label var pregstart_date "pregnancy start date"
label var deliverytype "types of delivery"

*drop unnecessary variables
drop mergesib2 
save "lsacb2-anyabx.dta", replace 


********************************************************************************
///							    Part 3 C									///

//merge all asthma outcomes, in each wave//

//asthma diagnosis = doctor's diagnosis + medication in last 12 months or wheeze in last 12 months

* hs29a - Has a doctor ever told you that child has asthma?
* hs29b - Has a doctor ever told you that child has asthma?
* hs15b - Has child had an illness with wheezing in the chest which lasted for a week or more in the last 12 months?


 
* wave 2 (age = 2/3)
		use "lsacgrb2.dta", replace

		keep hicid wave zf04m1 bhs29a bhs29b bhs15b
		sort hicid wave zf04m1 bhs29a bhs29b bhs15b
		save "lsacgrb2-keep.dta", replace

		gen asthmaw2 = .
		replace asthmaw2 = 0 if bhs29a ==1 & bhs29b !=1 | bhs29a == 1 & bhs15b !=1 | bhs29a==2 | bhs29b==2 |bhs15b==2
		replace asthmaw2 = 1 if bhs29a ==1 & bhs29b ==1 | bhs29a ==1 & bhs15b==1
		replace asthmaw2 = . if bhs29a == -2 | bhs29a == -4
		label var asthmaw2 "Number of wave 2 children who have asthma"
		label define asthmaw2lab 1 "Asthma" 0 "Healthy"
		label value asthmaw2 asthmaw2lab
		ta asthmaw2
		drop wave zf04m1 bhs29a bhs29b bhs15b
		save "lsacgrb2-keep.dta", replace

* repeat the rest of the waves 

////////////////////////////////////////////////////////////////

****************Merge with LSAC wave 0 (early-life abx --> outcome)*************

use "lsacb2-anyabx.dta", replace


*wave 2
		merge 1:1 hicid using "lsacgrb2-keep.dta", gen (mergegrb2_merge)
		ta mergegrb2_merge
		drop mergegrb2_merge


*Repeat the rest of waves 

		//ever had asthma
gen asthma_bin = .
replace asthma_bin = 1 if asthmaw4 == 1 | asthmaw5 == 1 | asthmaw6 == 1 | asthmaw7 == 1 | asthmaw8 == 1
replace asthma_bin = 0 if asthmaw4 == 0 & asthmaw5 == 0 & asthmaw6 == 0 & asthmaw7 == 0 & asthmaw8 == 0
label var asthma_bin "SC Ever had Asthma between wave 2 - wave 8"
label define asthma_binlab1 0 "never" 1 "ever"
label value asthma_bin asthma_binlab1
ta asthma_bin
		
		
save "lsacb2-asthma.dta", replace

------------------------------------------------------------------------------
*******************************************************************************

//				Part 4 Trajectory & multinomial analysis					//


use "lsacb2-asthma.dta", replace

net from http://www.andrew.cmu.edu/user/bjones/traj
net install traj, replace


gen wave2 = 2
gen wave3 = 4
gen wave4 = 6
gen wave5 = 8
gen wave6 = 10
gen wave7 = 12
gen wave8 = 14

		//generate current asthma variable for all waves. 

gen asthmab23 = .
replace asthmab23 = 1 if asthmaw2 == 1
replace asthmab23 = 0 if asthmaw2 == 0 
gen asthmab45 = .
replace asthmab45 = 1 if asthmaw3 == 1
replace asthmab45 = 0 if asthmaw3 == 0
gen asthmab67 = .
replace asthmab67 = 1 if asthmaw4 == 1
replace asthmab67 = 0 if asthmaw4 == 0
gen asthmab89 = .
replace asthmab89 = 1 if asthmaw5 == 1
replace asthmab89 = 0 if asthmaw5 == 0
gen asthmab1011 = .
replace asthmab1011 = 1 if asthmaw6 == 1
replace asthmab1011 = 0 if asthmaw6 == 0
gen asthmab1213 = .
replace asthmab1213 = 1 if asthmaw7 == 1
replace asthmab1213 = 0 if asthmaw7 == 0
gen asthmab1415 = .
replace asthmab1415 = 1 if asthmaw8 == 1
replace asthmab1415 = 0 if asthmaw8 == 0


		//generate variable for asthma across all waves
		
egen asthma_overall = rownonmiss(asthmab23 asthmab45 asthmab67 asthmab89 asthmab1011 asthmab1213 asthmab1415)
tab asthma_overall


*trajectory modelling for wave3-wave8 (children 4-15years), 4 groups
		
		//trajectory

traj if asthma_overall>2 , model(logit) var(asthmab45 asthmab67 asthmab89 asthmab1011 asthmab1213 asthmab1415) indep(wave3 wave4 wave5 wave6 wave7 wave8) order (1 1 1 1)

trajplot, xtitle("Age (years)") ytitle("Prevalence of asthma") xlabel(4(2)14) ci

label define _traj_Grouplab3 1 "early resolving asthma" 2 "always low risk" 3 "late onset asthma" 4 "early persistent asthma"
label value _traj_Group _traj_Grouplab3

ta _traj_Group

		//multinomial regression analyses


			//postnatal
mlogit _traj_Group i.post_abx2_bin maternalsmk maternalal maternaled cethnicity sep_5 lowbw_bin deliverytype preterm_cat maternalas_bin rurality formula bhs19b1 bhsib bosib, rrr base(2)


		save "lsacb2-traj.dta", replace


*******************************************************************************		
	
		
*******************************************************************************
///							Part 5 Subgroup analyses						///


// male vs. female trajectories & multinomial regression (4 groups, age 6-14)

use "D:\Calvin\Luyk\others\abx\LSAC\stata\lsacb2-traj.dta", replace

	//generate asthma variables for different times by sex
	
	//male & no missing values
	generate asthmab23m = .
	replace asthmab23m = 1 if asthmaw2 ==1 & zf02m1 == 1
	replace asthmab23m =0 if asthmaw2 ==0 & zf02m1 == 1
	
	
	generate asthmab45m = .
	replace asthmab45m = 1 if asthmaw3 ==1 & zf02m1 == 1
	replace asthmab45m =0 if asthmaw3 ==0 & zf02m1 == 1
	
	
	generate asthmab67m = .
	replace asthmab67m = 1 if asthmaw4 ==1 & zf02m1 == 1
	replace asthmab67m =0 if asthmaw4 ==0 & zf02m1 == 1
	
	
	generate asthmab89m = .
	replace asthmab89m = 1 if asthmaw5 ==1 & zf02m1 == 1
	replace asthmab89m =0 if asthmaw5 ==0 & zf02m1 == 1
	
	
	generate asthmab1011m = .
	replace asthmab1011m = 1 if asthmaw6 ==1 & zf02m1 == 1
	replace asthmab1011m =0 if asthmaw6 ==0 & zf02m1 == 1
	
	
	generate asthmab1213m = .
	replace asthmab1213m = 1 if asthmaw7 ==1 & zf02m1 == 1
	replace asthmab1213m =0 if asthmaw7 ==0 & zf02m1 == 1
	
	
	generate asthmab1415m = .
	replace asthmab1415m = 1 if asthmaw8 ==1 & zf02m1 == 1
	replace asthmab1415m =0 if asthmaw8 ==0 & zf02m1 == 1
	
	
	//female & no missing
	generate asthmab23f = .
	replace asthmab23f = 1 if asthmaw2 ==1 & zf02m1 == 2
	replace asthmab23f =0 if asthmaw2 ==0 & zf02m1 == 2
	
	generate asthmab45f = .
	replace asthmab45f = 1 if asthmaw3 ==1 & zf02m1 == 2
	replace asthmab45f =0 if asthmaw3 ==0 & zf02m1 == 2
	
	
	generate asthmab67f = .
	replace asthmab67f = 1 if asthmaw4 ==1 & zf02m1 == 2
	replace asthmab67f =0 if asthmaw4 ==0 & zf02m1 == 2
	
	
	generate asthmab89f = .
	replace asthmab89f = 1 if asthmaw5 ==1 & zf02m1 == 2
	replace asthmab89f =0 if asthmaw5 ==0 & zf02m1 == 2
	
	
	generate asthmab1011f = .
	replace asthmab1011f = 1 if asthmaw6 ==1 & zf02m1 == 2
	replace asthmab1011f =0 if asthmaw6 ==0 & zf02m1 == 2
	
	
	generate asthmab1213f = .
	replace asthmab1213f = 1 if asthmaw7 ==1 & zf02m1 == 2
	replace asthmab1213f =0 if asthmaw7 ==0 & zf02m1 == 2
	
	
	generate asthmab1415f = .
	replace asthmab1415f = 1 if asthmaw8 ==1 & zf02m1 == 2
	replace asthmab1415f =0 if asthmaw8 ==0 & zf02m1 == 2
	
	//traj male
	traj if asthma_overall>2 , model(logit) var(asthmab45m asthmab67m asthmab89m asthmab1011m asthmab1213m asthmab1415m) indep(wave3 wave4 wave5 wave6 wave7 wave8) order (1 1 1 1)
	
	trajplot, xtitle("Age (years)") ytitle("Prevalence of asthma") xlabel(4(2)14) ci
	
	//only using traj group with males
	generate allergy_traj=1 if _traj_Group==1 & zf02m1==1
	replace allergy_traj=2 if _traj_Group==2& zf02m1==1
	replace allergy_traj=3 if _traj_Group==3& zf02m1==1
	replace allergy_traj=4 if _traj_Group==4& zf02m1==1
	tabulate allergy_traj
	
	label define allergy_trajlab38 1 "Early-resolving asthma" 2 "Always low risk" 3 "late-onset asthma" 4 "Early persistent asthma"
	label value allergy_traj allergy_trajlab38
	
	mlogit allergy_traj i.post_abx2_bin maternalsmk maternalal maternaled cethnicity sep_5 lowbw_bin deliverytype preterm_cat maternalas_bin rurality formula bhs19b1 bhsib bosib ahs17g ahs17h, rrr base(2)
	
	

--------------------------------------------------------------------------------
	
	
	//traj female
	traj if asthma_overall>2 , model(logit) var(asthmab45f asthmab67f asthmab89f asthmab1011f asthmab1213f asthmab1415f) indep(wave3 wave4 wave5 wave6 wave7 wave8) order (1 1 1 2)
	
	trajplot, xtitle("Age (years)") ytitle("Prevalence of asthma") xlabel(4(2)14) ci

	*label
	group 1 (Always low risk)
	group 2 (Late onset asthma)
	group 3 (Early resolving)
	group 4 (Early persistent)
	
	//only using traj group with females
	generate fallergy_traj=1 if _traj_Group==1 & zf02m1==2
	replace fallergy_traj=2 if _traj_Group==2& zf02m1==2
	replace fallergy_traj=3 if _traj_Group==3& zf02m1==2
	replace fallergy_traj=4 if _traj_Group==4& zf02m1==2
	tabulate fallergy_traj
	label define fallergy_trajlab44 1 "Early-resolving" 2 "always low risk" 3 "late-onset" 4 "Early persistent asthma"
label value fallergy_traj allergy_trajlab44

	mlogit fallergy_traj i.post_abx2_bin maternalsmk maternalal maternaled cethnicity sep_5 lowbw_bin deliverytype preterm_cat maternalas_bin rurality formula bhs19b1 bhsib bosib ahs17g ahs17h, rrr base(2)
	
	
--------------------------------------------------------------------------------
*test for interaction for sex (need to drop sex-specific traj_Group and re-do traj calculation.
drop _traj_Group
traj if asthma_overall>2 , model(logit) var(asthmab45 asthmab67 asthmab89 asthmab1011 asthmab1213 asthmab1415) indep(wave3 wave4 wave5 wave6 wave7 wave8) order (1 1 1 1)

mlogit _traj_Group i.post_abx2_bin#i.zf02m1 maternalsmk maternalal maternaled cethnicity sep_5 lowbw_bin deliverytype preterm_cat maternalas_bin rurality formula bhs19b1 bhsib bosib ahs17g ahs17h, rrr base(2)
estimates store model
	
save "lsacb2-trajsex.dta", replace
end

--------------------------------------------------------------------------------


-----------------------------------------
	

*******************************************************
