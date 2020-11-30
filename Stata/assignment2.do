*Assignment 2 .do file to create log.*/
log using ASSN2, replace
clear
cd "C:\Users\sparshk\OneDrive - Syracuse University\quant"

use "C:\Users\sparshk\OneDrive - Syracuse University\quant\randhie.dta"

*Basic summary and data format information for data.*
describe
summarize

*How many unique participants?*
codebook person

*Age distribution of participants?*
summ age, detail

*Racial makeup of participants? Missing data?*
tab race, miss

*Counts of participants in RAND health insurance groups.*
tab rand_plan_group, miss

*Comparing difference in means for average age of participants on HIPs.*
tab rand_plan_group, nolabel
ttest age if rand_plan_group==1 | rand_plan_group==5, by(rand_plan_group)

*Create indicator variable for catastrophic plan.*
gen catastrophic = 1 if rand_plan_group==5
replace catastrophic = 0 if catastrophic==.
tab catastrophic rand_plan_group

*Bivariate regression on spending and catastrophic plan, restricted comparison*
*against free plan and catastrophic plan.*
regress spending catastrophic if rand_plan_group==1 | rand_plan_group==5, robust

*Multivariate regression on spending, catastrophic plan, and age*
*restricted comparison against free plan and catastrophic plan.*
regress spending catastrophic age if rand_plan_group==1 | ///
rand_plan_group==5, robust

log close