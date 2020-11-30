*Assignment 4 .do file to create log.*/
log using ASSN4, replace
clear
cd "C:\Users\sparshk\OneDrive - Syracuse University\quant"

use "C:\Users\sparshk\OneDrive - Syracuse University\quant\caschool.dta"

*Basic summary and data format information for data.*
describe
summarize

*1. Polynomial regression.*
*Generate squared average income, regress on quadratic function.*
gen avginc2 = avginc*avginc
regress testscr avginc avginc2, robust

regress testscr avginc avginc2, robust
test avginc2

*2. Logistic regression*
*Generate a log of average income, run regression controlling student-teacher ratios.*
gen lnavginc = ln(avginc)
regress testscr str lnavginc, robust

*3. Interactions of X.*
*Generate indicator variables for class size ratios and % English learners.*
gen HiSTR=1 if str>=20
replace HiSTR=0 if str<20

gen HiEL=1 if elpct>=10
replace HiEL=0 if elpct<10

*Create interaction of indicator variables, regress test scores on indicator variables and their interaction.
gen HiSTRxHiEL = HiSTR*HiEL
regress testscr HiSTR HiEL HiSTRxHiEL, robust

*Create interaction between binary and continuous variable.*
gen HiELxstr = HiEL*str
regress testscr HiEL str HiELxstr, robust

log close