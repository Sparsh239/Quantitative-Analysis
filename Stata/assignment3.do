*Assignment 3 .do file to create log.*/
log using ASSN3, replace
clear
cd "C:\Users\sparshk\OneDrive - Syracuse University\quant"

use "C:\Users\sparshk\OneDrive - Syracuse University\quant\guns.dta"

*Basic summary and data format information for data.*
describe
summarize

*Regress violent crime rate on shall-carry indicator.*
regress vio shall, robust

*Regress violent crime rate on shall-carry indicator & average income.*
regress vio shall avginc, robust

*Regress violent crime rate on shall-carry indicator, average income, & population density.*
regress vio shall avginc density, robust

*Regress population density on shall-carry indicator.*
regress density shall, robust

*Regress violent crime rate on shall-carry indicator & population density.*
regress vio shall density, robust
clear

use "C:\Users\lsquick\OneDrive - Syracuse University\quant\college.dta"

*Basic summary and data format information for data.*
describe
summarize

*Regress completed schooling on nearest college distance.*
regress yrsed dist, robust

*Omitted Variable Bias*
*Regress parental education on distance. Regress completed schooling on nearest college distance.
regress parcoll dist, robust
regress yrsed dist parcoll, robust

*Multivariate regression on years of education.*
regress yrsed dist parcoll black hisp tuition, robust

*F-test: distance and tuition are not determinants of years of schooling.
regress yrsed dist tuition, robust
test (dist=0)(tuition=0)

log close