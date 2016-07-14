# iemiscdata

R data package with miscellaneous data sets [Engineering Economics, Environmental/Water Resources Engineering, US Presidential Elections].


# Installation

```R
install.packages("iemiscdata")
```


# Package Contents
This package currently contains 26 datasets:

* `nchannel`: Manning's n for Channels (Chow, 1959)
* `npartfull`: Manning's n for Closed Conduits Flowing Partly Full (Chow, 1959)
* `nmetalpipe`: Manning's n for Corrugated Metal Pipe (AISI, 1980)
* `r* (3 data sets)`: Nominal Interest Rate Tables (Engineering Economics)
* `i* (19 data sets)`: Effective Interest Rate Tables (Engineering Economics)
* `pres_elect1`: US Presidential Elections (Wikipedia)



# Examples (see more examples in the vignettes and in the function descriptions)
```R
library(install.load)
load_package("iemisc", "iemiscdata", "data.table", "dplyr", "rpivotTable") # load needed packages using the load_package function from the install.load package (it is assumed that you have already installed these packages)


# Example 1
# Future value given present value
FgivenP(8330, 6, 10, frequency = "annual") # the interest rate is 10%

# or

P <- 8330
n <- 6
P * i10[n, which(names(i10) == "F/P"), with = FALSE][[1]]
# use i10 for the 10 percent effective interest table values
# n is the row number
# which(names(i10) == "F/P"), with = FALSE provides the column number in a data.table
# [[1]] provides the value of the vector



# Example 2
# Future value given annual value with continuously compounded interest
FgivenAcont(4500, 5, 20) # 20% interest

# or

F <- 4500
n <- 5
F * r20[n, which(names(r20) == "F/A"), with = FALSE][[1]]
# use r20 for the 20 percent nominal interest table values
# n is the row number
# which(names(r20) == "F/A"), with = FALSE provides the column number in this data.table
# [[1]] provides the value of the vector



# Example 3
# View the Manning's n data sets

View(nchannel)

View(nmetalpipe)

View(npartfull)



# Example 4
# View the Wikipedia US Presidental Election Results Table

View(pres_elect1)


# The number of elections won by the Winners of the Presidential Election using dplyr's count along with piping
pres_elect1 %>% count(Winner)


# view the interactive pivot table of the whole table
rpivotTable(pres_elect1)


# view the interactive pivot table using the Winner Party column
rpivotTable(pres_elect1, cols = "Winner Party")
```



# Disclaimer

This software is provided "AS IS." See the GPL License for more information.


# License

iemiscdata is distributed under the GPL-3 (or later) license, as stated in the DESCRIPTION file. For more info, see the [GNU General Public License (GPL) page](https://gnu.org/licenses/gpl.html).
