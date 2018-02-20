country_codes = c(
  32, # Argentina
  36, # Australia
  76, # Brazil
  152,  # Chile
  156,  # China
  170,  # Colombia
  196,  # Cyprus
  818,  # Egypt
  246,  # Finland
  268,  # Georgia
  276,  # Germany
  288,  # Ghana
  344,  # Hong Kong
  348,  # Hungary
  356,  # India
  368,  # Iraq
  392,  # Japan
  400,  # Jordan
  458,  # Malaysia
  484,  # Mexico
  504,  # Morocco
  528,  # Netherlands
  554,  # New Zealand
  616,  # Poland
  643,  # Russia
  710,  # South Africa
  410,  # South Korea
  724,  # Spain
  752,  # Sweden
  158,  # Taiwan
  764,  # Thailand
  792,  # Turkey
  804,  # Ukraine
  840   # United States
)

countries = c(
  "Argentina",
  "Australia",
  "Brazil",
  "Chile",
  "China",
  "Colombia",
  "Cyprus",
  "Egypt",
  "Finland",
  "Georgia",
  "Germany",
  "Ghana",
  "Hong Kong",
  "Hungary",
  "India",
  "Iraq",
  "Japan",
  "Jordan",
  "Malaysia",
  "Mexico",
  "Morocco",
  "Netherlands",
  "New Zealand",
  "Poland",
  "Russia",
  "South Africa",
  "South Korea",
  "Spain",
  "Sweden",
  "Taiwan",
  "Thailand",
  "Turkey",
  "Ukraine",
  "United States"
)

mergeLength <- function(frame, country_codes, countries, columns, column_labels) {
  base <- data.frame(V2=country_codes)
  coolFrame <- frame[frame$V2 %in% country_codes,]
  base <- merge(base, unique(coolFrame["V2"]))
  for (i in 1:length(columns)) {
    column <- columns[i]
    label <- column_labels[i]
    temp <- setNames(
      aggregate(coolFrame[,c("V2", column)][[column]], FUN=length, by=list(coolFrame$V2, coolFrame[[column]])),
      c("V2", "x", label))
    base = merge(x = base, y = temp, all = TRUE)
    
    #print(base)
  }
  base <- merge(base, data.frame(V2=country_codes, country=countries))
  base
}

# PUT YOUR COLUMNS HERE
column_labels <- c("MaritalStatus", "Children", "LifeMeaning", "ServiceAttend", "ReligiousPerson", "JustifyHomosexuality", "JustifyAbortion", "JustifyDivorce", "PoliticalScale")
column_wv1 <- c("V89",  "V90",  "V177", "V181", "V182", "V197", "V199", "V200", "V123")
column_wv2 <- c("V181", "V211", "V133", "V147", "V151", "V307", "V309", "V310", "V248")
column_wv3 <- c("V89",  "V90",  "V177", "V181", "V182", "V197", "V199", "V200", "V123")
column_wv4 <- c("V106", "V107", "V182", "V185", "V186", "V208", "V210", "V211", "V139")
column_wv5 <- c("V55",  "V56",  "V184", "V186", "V187", "V202", "V204", "V205", "V114")
column_wv6 <- c("V57",  "V58",  "V143", "V145", "V147", "V203", "V204", "V205", "V95")

#column_labels <- c("Justifiable: Abortion", "Justifiable: Divorce", "Religion", "Political scale")
#column_wv1 <- c("V199", "V200", "V179", "V123")

# WV1_Data_R_v_2015_04_18
# WV2_Data_R_v_2015_04_18
# WV3_Data_R_v_2015-04-18

merged <- mergeLength(WV3_Data_R_v_2015-04-18, country_codes, countries, column_wv3, column_labels)

#merged

write.csv(merged, file = "wv3.csv") 
# http://rprogramming.net/write-csv-in-r/
country_codes = c(
  32, # Argentina
  36, # Australia
  76, # Brazil
  152,  # Chile
  156,  # China
  170,  # Colombia
  196,  # Cyprus
  818,  # Egypt
  246,  # Finland
  268,  # Georgia
  276,  # Germany
  288,  # Ghana
  344,  # Hong Kong
  348,  # Hungary
  356,  # India
  368,  # Iraq
  392,  # Japan
  400,  # Jordan
  458,  # Malaysia
  484,  # Mexico
  504,  # Morocco
  528,  # Netherlands
  554,  # New Zealand
  616,  # Poland
  643,  # Russia
  710,  # South Africa
  410,  # South Korea
  724,  # Spain
  752,  # Sweden
  158,  # Taiwan
  764,  # Thailand
  792,  # Turkey
  804,  # Ukraine
  840   # United States
)

countries = c(
  "Argentina",
  "Australia",
  "Brazil",
  "Chile",
  "China",
  "Colombia",
  "Cyprus",
  "Egypt",
  "Finland",
  "Georgia",
  "Germany",
  "Ghana",
  "Hong Kong",
  "Hungary",
  "India",
  "Iraq",
  "Japan",
  "Jordan",
  "Malaysia",
  "Mexico",
  "Morocco",
  "Netherlands",
  "New Zealand",
  "Poland",
  "Russia",
  "South Africa",
  "South Korea",
  "Spain",
  "Sweden",
  "Taiwan",
  "Thailand",
  "Turkey",
  "Ukraine",
  "United States"
)

mergeLength <- function(frame, country_codes, countries, columns, column_labels) {
  base <- data.frame(V2=country_codes)
  coolFrame <- frame[frame$V2 %in% country_codes,]
  base <- merge(base, unique(coolFrame["V2"]))
  for (i in 1:length(columns)) {
    column <- columns[i]
    label <- column_labels[i]
    temp <- setNames(
      aggregate(coolFrame[,c("V2", column)][[column]], FUN=length, by=list(coolFrame$V2, coolFrame[[column]])),
      c("V2", "x", label))
    base = merge(x = base, y = temp, all = TRUE)
    
    #print(base)
  }
  base <- merge(base, data.frame(V2=country_codes, country=countries))
  base
}

# PUT YOUR COLUMNS HERE
column_labels <- c("MaritalStatus", "Children", "LifeMeaning", "ServiceAttend", "ReligiousPerson", "JustifyHomosexuality", "JustifyAbortion", "JustifyDivorce", "PoliticalScale")
column_wv1 <- c("V89",  "V90",  "V177", "V181", "V182", "V197", "V199", "V200", "V123")
column_wv2 <- c("V181", "V211", "V133", "V147", "V151", "V307", "V309", "V310", "V248")
column_wv3 <- c("V89",  "V90",  "V177", "V181", "V182", "V197", "V199", "V200", "V123")
column_wv4 <- c("V106", "V107", "V182", "V185", "V186", "V208", "V210", "V211", "V139")
column_wv5 <- c("V55",  "V56",  "V184", "V186", "V187", "V202", "V204", "V205", "V114")
column_wv6 <- c("V57",  "V58",  "V143", "V145", "V147", "V203", "V204", "V205", "V95")

#column_labels <- c("Justifiable: Abortion", "Justifiable: Divorce", "Religion", "Political scale")
#column_wv1 <- c("V199", "V200", "V179", "V123")

# WV1_Data_R_v_2015_04_18
# WV2_Data_R_v_2015_04_18
# `WV3_Data_R_v_2015-04-18`
# `WV4_Data_R_v_2015-04-18`
# WV5_Data_r_v_2015_04_18"
# WV6_Data_v_2015_04_18

merged <- mergeLength(WV6_Data_v_2015_04_18, country_codes, countries, column_wv6, column_labels)

#merged

write.csv(merged, file = "wv6.csv") 
# http://rprogramming.net/write-csv-in-r/
