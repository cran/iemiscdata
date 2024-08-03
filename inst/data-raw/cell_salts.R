SPECIALS = c('row.names', 'rownames', 'names')

#' Look up values in dictionary [from the 'expss' package version 0.10.7]
#' 
#' \code{vlookup}/\code{vlookup_df} function is inspired by VLOOKUP spreadsheet
#' function. It looks for a \code{lookup_value} in the \code{lookup_column} of
#' the \code{dict}, and then returns values in the same rows from
#' \code{result_column}. \code{add_columns} inspired by MATCH FILES (Add
#' variables...) from SPSS Statistics. It works similar to SQL left join but
#' number of cases in the left part always remain the same. If there are
#' duplicated keys in the \code{dict} then error will be raised by default.
#' \code{.add_columns} is the same function for default dataset.
#' 
#' @param lookup_value Vector of looked up values
#' @param dict data.frame/matrix. Dictionary. Can be vector for
#'   \code{vlookup}/\code{vlookup_df}.
#' @param result_column numeric or character. Resulting columns of \code{dict}.
#'   There are special values: 'row.names', 'rownames', 'names'. If
#'   \code{result_column} equals to one of these special values and \code{dict}
#'   is matrix/data.frame then row names of \code{dict} will be returned. If
#'   \code{dict} is vector then names of vector will be returned. For
#'   \code{vlookup_df} default \code{result_column} is NULL and result will be
#'   entire rows. For \code{vlookup} default \code{result_column} is 2 - for
#'   frequent case of dictionary with keys in the first column and results in
#'   the second column.
#' @param lookup_column Column of \code{dict} in which lookup value will be
#'   searched. By default it is the first column of the \code{dict}. There are
#'   special values: 'row.names', 'rownames', 'names'. If lookup_column equals
#'   to one of these special values and \code{dict} is matrix/data.frame then
#'   values will be searched in the row names of \code{dict}. If \code{dict} is
#'   vector then values will be searched in names of the \code{dict}.
#' @param data data.frame to be joined with \code{dict}.
#' @param by character vector or NULL(default) or 1. Names of common variables
#'   in the \code{data} and \code{dict} by which we will attach \code{dict} to
#'   \code{data}. If it is NULL then common names will be used. If it is equals
#'   to 1 then we will use the first column from both dataframes. To add columns
#'   by different variables on \code{data} and \code{dict} use a named vector.
#'   For example, \code{by = c("a" = "b")} will match data.a to dict.b.
#' @param ignore_duplicates logical Should we ignore duplicates in the \code{by}
#'   variables in the \code{dict}? If it is TRUE than first occurrence of duplicated
#'   key will be used.
#' @return \code{vlookup} always return vector, \code{vlookup_df} always returns
#'   data.frame. \code{row.names} in result of \code{vlookup_df} are not
#'   preserved.
#' 
#' @author Gregory Demin and Sebastian Jeworutzki ('expss' package version 0.10.7)
#' 
#'
#' 
#' @export
vlookup <- function(lookup_value, dict, result_column = 2, lookup_column = 1){
    stopif(length(result_column)>1, "result_column shoud be vector of length 1.")
    vlookup_internal(lookup_value = lookup_value, 
                     dict = dict, 
                     result_column = result_column, 
                     lookup_column = lookup_column, df = FALSE)
}


#' @export
#' @rdname vlookup
vlookup_df <- function(lookup_value, dict, result_column = NULL, lookup_column = 1) {
    vlookup_internal(lookup_value = lookup_value, 
                     dict = dict, 
                     result_column = result_column, 
                     lookup_column = lookup_column, df = TRUE)
}


#' @export
#' @rdname vlookup
add_columns <- function(data, dict, 
                       by = NULL, 
                       ignore_duplicates = FALSE
){
    UseMethod("add_columns")
    
}

#' @importFrom data.table is.data.table :=
#' @export
add_columns.data.frame <- function(data, dict, 
                       by = NULL, 
                       ignore_duplicates = FALSE
){
    if(!is.data.frame(data)) data = as.sheet(data)
    if(!is.data.frame(dict)) dict = as.sheet(dict)
    # ..by_data = NULL
    # ..by = NULL
    colnames_data = colnames(data)
    colnames_dict = colnames(dict)
    if(is.null(by)){
        by = intersect(colnames_data, colnames_dict)
        stopif(length(by)==0, "'add_columns' - no common column names between 'data' and 'dict'.")
        message(paste0("Adding columns by ", paste(dQuote(by), collapse = ", ")))
    }
    if(identical(by, 1) || identical(by, 1L)){
        lookup_value = data[[1]]    
        lookup_column = dict[[1]]   
        col_nums_dict = 1
    } else {
        stopif(!is.character(by), "'add_columns' - 'by' should be character, NULL or 1.")
        if(!is.null(names(by))){
            by_data = names(by)
            by_data[by_data==""] = by[by_data==""]
        } else {
            by_data = by
        }
        stop_if_columns_not_exist(colnames_data, by_data)
        stop_if_columns_not_exist(colnames_dict, by)
        if(length(by)>1){
            stopif(anyDuplicated(by), "'add_columns'- duplicated variable names in 'by': ", 
                   paste(dQuote(by[duplicated(by)]), collapse = ", "))
            stopif(anyDuplicated(by_data), "'add_columns'- duplicated variable names in 'by': ", 
                   paste(dQuote(by_data[duplicated(by_data)]), collapse = ", "))
            if(data.table::is.data.table(data)){
                lookup_value = data[ , by_data, with = FALSE]     
            } else {
                lookup_value = data[ , by_data]
            }
            if(data.table::is.data.table(dict)){
                lookup_column = dict[ , by, with = FALSE]                     
            } else {
                lookup_column = dict[ , by] 
            }
            lookup_value = do.call("paste", c(unlab(lookup_value), sep = "\r"))
            lookup_column = do.call("paste", c(unlab(lookup_column), sep = "\r"))
        } else {
            lookup_value = data[[by_data]]    
            lookup_column = dict[[by]]  
        }
        col_nums_dict = match(by, colnames_dict)
    }
    if(!ignore_duplicates){
        stopif(anyDuplicated(lookup_column), 
               "'add_columns' - duplicated values in 'by' columns in 'dict'")
    }
    # calculate index
    ind = fast_match(lookup_value, lookup_column, NA_incomparable = FALSE)
    if(data.table::is.data.table(dict)){
        res = subset_dataframe(dict[,-col_nums_dict, with = FALSE], ind, drop = FALSE)    
    } else {
        res = subset_dataframe(dict[,-col_nums_dict, drop = FALSE], ind, drop = FALSE)    
    }
    
    # make unique names in res
    colnames_res = colnames(res)
    dupl = intersect(colnames_res, colnames_data)
    if(length(dupl)>0){
        warning(
            paste0("'add_columns' - some names in 'dict' duplicate names in 'data': ",
                   paste(dupl, collapse = ", ")
                   )
            )
        all_names = make.unique(c(colnames_data, colnames_res), sep = "_")
        # we change only dictionary names 
        colnames(res) = all_names[-seq_along(colnames_data)]
    }
    if(data.table::is.data.table(data)){
        data[, colnames(res):=res]    
    } else {
        data[, colnames(res)] = res    
    }
    
    data

}




#' @importFrom huxtable add_columns
#' @export
add_columns.huxtable <- function(...){
    huxtable::add_columns(...)
}

#' @export
#' @rdname vlookup
.add_columns <- function (dict, 
                         by = NULL, 
                         ignore_duplicates = FALSE) {
    reference = suppressMessages(default_dataset())
    data = ref(reference)
    data = add_columns(data, 
                       dict = dict, 
                       by = by, 
                       ignore_duplicates = ignore_duplicates)
    ref(reference) = data
    invisible(data)
}





#' This is the vlookup_internal function
#' 
#' Internal vlookup function
#' 
#' @param df logical vector. If TRUE, it's a data.frame (default). If FALSE, it's
#'   not a data.frame.
#' @param lookup_value Vector of looked up values
#' @param dict data.frame/matrix. Dictionary. Can be vector for
#'   vlookup/vlookup_df.
#' @param result_column numeric or character. Resulting columns of dict.
#'   There are special values: 'row.names', 'rownames', 'names'. If
#'   result_column equals to one of these special values and dict
#'   is matrix/data.frame then row names of dict will be returned. If
#'   dict is vector then names of vector will be returned. For
#'   vlookup_df default result_column is NULL and result will be
#'   entire rows. For vlookup default result_column is 2 - for
#'   frequent case of dictionary with keys in the first column and results in
#'   the second column.
#' @param lookup_column Column of dict in which lookup value will be
#'   searched. By default it is the first column of the dict. There are
#'   special values: 'row.names', 'rownames', 'names'. If lookup_column equals
#'   to one of these special values and dict is matrix/data.frame then
#'   values will be searched in the row names of dict. If dict is
#'   vector then values will be searched in names of the dict.
#' @param data data.frame to be joined with dict.
#' @param by character vector or NULL(default) or 1. Names of common variables
#'   in the data and dict by which we will attach dict to
#'   data. If it is NULL then common names will be used. If it is equals
#'   to 1 then we will use the first column from both dataframes. To add columns
#'   by different variables on data and dict use a named vector.
#'   For example, by = c("a" = "b") will match data.a to dict.b.
#' @param ignore_duplicates logical Should we ignore duplicates in the by
#'   variables in the dict? If it is TRUE than first occurrence of duplicated
#'   key will be used.
#' @return vlookup_internal is an internal function.
#'   
#' @author Gregory Demin and Sebastian Jeworutzki ('expss' package version 0.10.7)
#'  
#'  
#' @noRd
#' @keywords internal
vlookup_internal <- function(lookup_value, 
                            dict, 
                            result_column = NULL, 
                            lookup_column = 1, 
                            df = TRUE) {
    stopif(is.list(lookup_value) || NCOL(lookup_value)!=1,
           "'vlookup' - incorrect 'lookup_value'. 'lookup_value' should be vector but its class is ", 
           paste(class(lookup_value), collapse = ", "))
    # validate lookup_column
    stopif(length(lookup_column)!=1L,"'vlookup' - 'lookup_column' shoud be vector of length 1.")
    stopif(!is.numeric(lookup_column) && !is.character(lookup_column),
           "'vlookup' - 'lookup_column' shoud be character or numeric.")
    stopif(is.numeric(lookup_column) && max(lookup_column,na.rm = TRUE)>NCOL(dict),
           "'vlookup' - 'lookup_column' is greater than number of columns in the dict.")
    stopif(is.numeric(lookup_column) && any(lookup_column <= 0),
           "'vlookup' - 'lookup_column' should be positive.")
    stopif(is.character(lookup_column) && (is.data.frame(dict) || is.matrix(dict)) && 
               !all(setdiff(lookup_column, SPECIALS) %in% colnames(dict)),
           "'vlookup' - 'lookup_column' doesn't exists in column names of the dict.")
    
    
    # validate result_column
    stopif(!is.null(result_column) && any(is.na(result_column)), "NA's in result_column")
    
    stopif(is.numeric(result_column) && max(result_column,na.rm = TRUE)>NCOL(dict),
           "result_column is greater than number of columns in the dict.")
    stopif(is.character(result_column) && (is.data.frame(dict) || is.matrix(dict)) && 
               !all(setdiff(result_column, SPECIALS) %in% colnames(dict)),
           "some names in result_column doesn't exists in column names of the dict.")
    
    if(is.matrix(dict) || is.data.frame(dict)){
        dict_was_vector = FALSE    
    } else {
        dict_was_vector = TRUE    
    }    
    if(any(SPECIALS %in% result_column) || any(SPECIALS %in% lookup_column)){
        if(is.matrix(dict) || is.data.frame(dict)){
            curr_rowlabs = rownames(dict)
            
        } else {
            curr_rowlabs = names(dict)
            
        }
    }
    if(!is.data.frame(dict)) dict = as.sheet(dict)
    if(any(SPECIALS %in% result_column) || any(SPECIALS %in% lookup_column)){
        dict[["...RRRLLL..."]] = curr_rowlabs
        if(any(SPECIALS %in% result_column)) result_column[result_column %in% SPECIALS] = "...RRRLLL..."
        if(any(SPECIALS %in% lookup_column)) lookup_column[lookup_column %in% SPECIALS] = "...RRRLLL..."
    }
    # calculate index
    ind = fast_match(lookup_value, dict[[lookup_column]], NA_incomparable = FALSE)
    ### calculate result
    if(df){
        if (is.null(result_column)){
            result = subset_dataframe(dict, ind, drop = FALSE)
        } else {
            
            result = subset_dataframe(dict, ind, drop = FALSE)[, result_column, drop = FALSE]
            
        }
        colnames(result)[colnames(result) %in% "...RRRLLL..."] = "row_names"
        # if(dict_was_vector) rownames(result) = NULL
    } else {
        if (is.null(result_column)){
            result = ind
        } else {
            result = dict[[result_column]][ind]
        }
           
    }
    result
}




## stop if condition with message
stopif <- function(cond,...){
    if (cond) {
        stop(do.call(paste0,c(list(...))),call. = FALSE)
    }
    invisible()
}


subset_dataframe <- function(x, j, drop = TRUE){
    if(NCOL(x)==1 && drop){
        return(x[[1]][j])    
    }
    res = lapply(x, universal_subset, j, drop = drop)
    class(res) = class(x)
    if(NCOL(x)>0){
        attr(res, "row.names") = seq_len(NROW(res[[1]]))
    }
    res
}



#' @importFrom data.table chmatch
fast_match <- function(x, table, nomatch = NA_integer_, NA_incomparable = FALSE){
    if(is.character(x) && is.character(table)){
        ind = data.table::chmatch(x, table, nomatch = nomatch) 
        if(NA_incomparable) {
            ind[is.na(x)] = nomatch
        }
    } else {
        if(NA_incomparable) {
            ind = match(x, table, 
                        nomatch = nomatch, 
                        incomparables = NA)
        } else {
            ind = match(x, table,
                        nomatch = nomatch, 
                        incomparables = NULL)
        }    
    }
    ind
}



#' @importFrom data.table is.data.table
universal_subset <- function(data, index, drop = TRUE){
    if(is.matrix(data)){
        data =  data[index, , drop = drop]
    } else if(is.data.frame(data)){
        if(data.table::is.data.table(data)){
            data = data[index, ]
        } else {
            data = subset_dataframe(data, index, drop = drop)
        }
    } else {
        data =  data[index]
    }
    data
}














# Human Cell Salts Table (27 of them)

install.load::load_package("data.table", "CHNOSZ", "iemiscdata", "stringi")

cell_salts <- data.table(CellSalts = c("Calcium fluoride", "Calcium phosphate", "Iron phosphate", "Potassium chloride", "Potassium phosphate", "Potassium sulphate", "Magnesium phosphate", "Sodium chloride", "Sodium phosphate", "Sodium sulphate", "Silica", "Calcium sulphate", "Potassium arsenite", "Potassium bromide", "Potassium iodide", "Lithium chloride", "Manganese sulfate", "Calcium sulfide", "Copper arsenite", "Alum", "Zinc chloride", "Calcium carbonate", "Sodium bicarbonate", "Arsenic iodide", "Aurum chloride sodium", "Selenium", "Potassium dichromate"), chemical_formula = c("CaF2", "Ca3(PO4)2", "FePO4", "KCl", "K3PO4", "K2SO4", "Mg3(PO4)2", "NaCl", "Na3PO4", "Na2SO4", "SiO2", "CaSO4", "KAsO2", "KBr", "KI", "LiCl", "MnSO4", "CaS", "CuAsHO3", "AlK(SO4)2 • 12H2O", "ZnCl2", "CaCO3", "NaHCO3", "AsI3", "AuCl4Na", "Se", "K2Cr2O7"))

setnames(cell_salts, c("Cell Salt", "Molecular Formula"))


# check for & replace non-ASCII strings

if(any(unlist(lapply(cell_salts, stri_enc_isascii)) == FALSE)) { # Source 1

check_ascii <- names(cell_salts)

# Source 2 begin
for (col in check_ascii) {

idx1 <- which(!stri_enc_isascii(cell_salts[[col]]))

set(cell_salts, i = idx1, j = col, value = stri_escape_unicode(cell_salts[[col]][idx1]))
}
# Source 2 end
}


save(cell_salts, file = "./data/cell_salts.rda")



# Total Number of Atoms of Elements in Human Cell Salts

chemical_formula <- c("CaF2", "Ca3(PO4)2", "FePO4", "KCl", "K3PO4", "K2SO4", "Mg3(PO4)2", "NaCl", "Na3PO4", "Na2SO4", "SiO2", "CaSO4", "KAsO2", "KBr", "KI", "LiCl", "MnSO4", "CaS", "CuAsHO3", "AlK(SO4)2", "(H2O)12", "ZnCl2", "CaCO3", "NaHCO3", "AsI3", "AuCl4Na", "Se", "K2Cr2O7")

cell_salts_atoms <- as.data.table(as.data.frame(makeup(chemical_formula, sum = TRUE)), keep.rownames = TRUE)

setnames(cell_salts_atoms, 1, "Formula")

setkey(cell_salts_atoms, Formula)


z <- vlookup_df(cell_salts_atoms$Formula, elements_pubchem, lookup_column = 3)

setkey(z, Formula)


cell_salts_atoms2 <- cell_salts_atoms[z, on="Formula"]


cell_salts_atoms_final <- subset(cell_salts_atoms2, select =  c("Formula", "makeup(chemical_formula, sum = TRUE)", "Name"))

setnames(cell_salts_atoms_final, c("Element Symbol", "Number of Atoms", "Element Name"))

setcolorder(cell_salts_atoms_final, c("Element Name", "Element Symbol", "Number of Atoms"))

save(cell_salts_atoms_final, file = "./data/cell_salts_atoms_final.rda")




# Create Awesome LaTeX Table with knitr::kable and kableExtra

Macronutrients <- c("Carbon (C)", "Hydrogen (H)", "Oxygen (O)", "Nitrogen (N)", "Phosphorus (P)", "Potassium (K)", "Calcium (Ca)", "Magnesium (Mg)", "Sulfur (S)", NA, NA)

Micronutrients <- c("Iron (Fe)", "Manganese (Mn)", "Boron (B)", "Molybdenum (Mo)", "Copper (Cu)", "Zinc (Zn)", "Chlorine (Cl)", "Nickel (Ni)", "Cobalt (Co)", "Sodium (Na)", "Silicon (Si)")

plant_essentials <- data.table(Macronutrients, Micronutrients)

setnames(plant_essentials, c("Elemental Macronutrients", "Elemental Micronutrients"))

save(plant_essentials, file = "./data/plant_essentials.rda")








## Resources

# The Human Cell Salts Table originally appeared in "Tuning to the Soil-ed Seed Vibrations For Our Collective Health" By Irucka Ajani Embry With Contributions By Obiora Embry, Page 13, Questioning the Universe Publishing (QUP), Paperback ISBN-13: 978-0-9914994-1-0 and Electronic book (EPUB) ISBN-13: 978-0-9914994-2-7 [https://www.qup.quest/soiled-seeds.html]

# https://stackoverflow.com/questions/78450114/r-total-sum-of-all-named-items-in-list-elements
# R - Total sum of all named items in list elements

# The full list of cell salt names came from:

# https://schuessler-cell-salts.com/
# Schuessler Cell Salts &mdash; 27 tissue salts for your health

# The chemical formulas were obtained from:

# https://pubchem.ncbi.nlm.nih.gov/
# National Library of Medicine PubChem


# The plant macro- and micro-nutrients were found on a table here:

# https://bio.libretexts.org/Bookshelves/Introductory_and_General_Biology/Book%3A_General_Biology_(Boundless)/31%3A_Soil_and_Plant_Nutrition/31.01%3A_Nutritional_Requirements_of_Plants/31.1C%3A_Essential_Nutrients_for_Plants  
#Biology LibreTexts: General Biology (Boundless): 31.1C: Essential Nutrients for Plants  






# Sources

# Source 1
# https://stackoverflow.com/questions/29043932/how-to-handle-example-data-in-r-package-that-has-utf-8-marked-strings
# twitter - How to handle example data in R Package that has UTF-8 marked strings - Stack Overflow

# Source 2
# https://stackoverflow.com/questions/50361168/r-data-table-set-add-number-to-certain-j-values-only | r - data.table set add number to certain j values only - Stack Overflow; answered by chinsoon12 on May 16 2018.
