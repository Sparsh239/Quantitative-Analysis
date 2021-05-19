*Assignment 5 .do file to create log.*/
log using ASSN5, replace
clear
cd "C:\Users\sparshk\OneDrive - Syracuse University\quant"

use "C:\Users\sparshk\OneDrive - Syracuse University\quant\drunkdri.dta"

*Basic summary and data format information for data.*
describe
summarize

*1. 1988 data.*
keep if (year == 1988)

*a. Scatterplot of vehicle fatality rate on beer tax. *
scatter vfrall beertax

*b. Raw regression.*
regress vfrall beertax mlda, robust

*c. Regression with state control variables.*
regress vfrall beertax mlda dry vmiles yngdrv perinc, robust

*2. Use full data set.*
clear
use "C:\Users\sparshk\OneDrive - Syracuse University\quant\drunkdri.dta"

*a. Full data regression with state control variables.*
regress vfrall beertax mlda dry vmiles yngdrv perinc, robust

*b. Regression with state control variables and year fixed effects.*
*Test year indicator variables for joint difference.*

regress vfrall beertax mlda dry vmiles yngdrv perinc i.year, robust
testparm i.year

*Another syntax option.*
*areg vfrall beertax mlda dry vmiles yngdrv perinc, absorb(year)*


*c. Add state and year fixed effects.*
xtset state
xtreg vfrall beertax mlda dry vmiles yngdrv perinc i.year, fe 
*vce(robust)*

*Another syntax option.*
*regress vfrall beertax mlda dry vmiles yngdrv perinc i.year i.state, robust*

*d. Non-linear.*
*Generate new drinking legalization age indicator variables.*
gen mlda18=1 if mlda<19
replace mlda18=0 if mlda>=19

gen mlda19=1 if mlda>=19 & mlda<20
replace mlda19=0 if mlda<19
replace mlda19=0 if mlda>=20

gen mlda20=1 if mlda>=20 & mlda<21
replace mlda20=0 if mlda<=20
replace mlda20=0 if mlda>=21

*Add legalization age indicator variables to prior regression.*
xtset state
xtreg vfrall beertax mlda18 mlda19 mlda20 dry vmiles yngdrv perinc i.year, fe

clear
use "C:\Users\sparshk\OneDrive - Syracuse University\quant\fastfood.dta"

*Create difference-in-differences regression.*
gen AFTER_NJ = AFTER*NJ

regress EMPFT AFTER NJ AFTER_NJ, robust

log close
