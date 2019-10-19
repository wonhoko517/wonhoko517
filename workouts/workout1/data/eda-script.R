# ===================================================================
# Title: WORKOUT01
# Description: The purpose of this assignment is threefold: 1) From the logistical point of view, this assignment will give you the opportunity to start working with a more complex ???le structure, and uploading ???les to your private classroom GitHub repository. 2) From the analytics point of view, this HW involves visualizing trajectories of storms around the world. 3) From the report/communication standpoint, you will have to produce a report document that is not just a boring list of code-chunks and outputs without a narrative.
# Input(s): data file 'ibtracs-2010-2015.csv'
# Output(s): summary data files, and plots
# Author: Wonho Ko
# Date: 10-18-2019
# Code: 
column_names <- c(
"Serial_Num",
"Season",
"Num",
"Basin",
"Sub_basin",
"Name",
"ISO_time",
"Nature",
"Latitude",
"Longitude",
"Wind(WMO)",
"Pres(WMO)"
)

column_types <- c(
  "character",
  "integer",
  "character",
  "factor",
  "character",
  "character",
  "character",
  "character",
  "Real",
  "Real",
  "Real",
  "Real"
)

origin <- '/Users/wonho/Desktop/workout1/data/ibtracs-2010-2015.csv'

dat <- read_csv(origin, sep = ",", col.names = column_names, colClasses = column_types)

sink(file = 'ibtracs-2010-2015.csv')
str(dat)
sink()
# ===================================================================