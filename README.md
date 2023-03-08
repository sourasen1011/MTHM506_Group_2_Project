# MTHM506_Group_2_Project
This is the repository for the Group Project of UoE MTHM506 Statistical Data Modelling for Group 2

# **Meeting notes**
#### 8.3.23

**Action Items**:
1. Souradeep to share Bayesian Analysis MTHM308 model solution as a reference for how to structure a mathematical modeling paper. Please check the github link <https://github.com/sourasen1011/MTHM506_Group_2_Project>

**Project Approach:**

1. **Problem Statement:** Clear description of what is expected for the assignment and how the data will inform our decisions.
2. **Exploratory Data Analysis:** This should cover no more than $\frac{3}{4}$ page or 1 full page (at most). No graphs or diagrams on this page - if any are required, they should be linked to in the appendix.
Should cover basic descriptive statistics such as mean, variance, quartiles (the summary function in R is probably a good fit for describing datasets) as well as detail any missing data and how to handle such instances.
3.**Modelling:** Since we are being asked to model a rate (rate of infection), we must select an appropriate model. We can model $\eta_{ij}$ as $log(case\ rate) + log(population) = $ linear predictor, where $log(case\ rate)$ can act as an offset term (think without coefficient $\beta$, but of course this definition may be slightly misplaced in a GAM context)
The notable ones that come to mind are:
* Beta distribution
* Negative binomial distribution
* Poisson
4. **Model Checking:**
* Residual checking
* Interpretation of coefficients (again, may be kind of futile in a GAM context)
* Varying $k'$ for different EDF to see how well the model fits and generalizes
* Hypothesis tests and LRT to ascertain if chosen model(s) is a good fit against the saturated model
5. **Critical review:**
* What are the limitations of the model?
* Did we discard / leave out certain covariates? Why? What would have been the effect had we included them?
* Comparison with few iterations to show that we selected the 'best' model based on some criteria (AIC perhaps).

**Final remarks:**
It was decided that a full-on literature review to accompany this may be overkill. So, we can resort to referencing in the usual way - most of the references we need should be in the book provided by Prof Thomas - Wood, S. N. (2017). Generalized Additive Models: An Introduction with R (2nd ed.). CRC Press.

## **ARCHIVAL**
Criteria for marking
* [15 marks] Understanding and exploration of both the problem and the data.
*[10 marks] Thoroughness and rigour, e.g. clear mathematical description of models.
* [25 marks] Clear exposition of the steps you took in model fitting and exposition of a final model.
* [20 marks] Clear presentation and interpretation of results.
* [10 marks] Critical review of the analysis.
* [20 marks] Clarity and conciseness in writing and tidy presentation of R code and associated plots.