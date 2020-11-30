*Assignment 1 .do file to create log.*/
log using ASSN1, replace
clear
cd "C:\Users\sparshk\OneDrive - Syracuse University\quant"

use "C:\Users\sparshk\OneDrive - Syracuse University\quant\classsize.dta"

*Q6: How many unique students in dataset?*/
describe
summarize

*Create indicator variables for female and white students.*/
tab gender
gen female = 1 if gender==2
replace female=0 if female==.
tab gender female

tab race
gen white = 1 if race==1
replace white=0 if white==.
tab race white

*Use tabstat to generate mean, standard deviation, & standard error for vars.*
tabstat female, by (gkclasstype) stat(mean sd semean)
tabstat white, by (gkclasstype) stat(mean sd semean)
tabstat gkclasssize, by (gkclasstype) stat(mean sd semean)
tabstat scorepct, by (gkclasstype) stat(mean sd semean)

log close