country_codes = c(
  32, # Argentina
  36, # Australia
  76, # Brazil
  152,  # Chile
  156,  # China
  170,  # Colombia
  196,  # Cyprus
  818,  # Egypt
  268,  # Georgia
  276,  # Germany
  288,  # Ghana
  344,  # Hong Kong
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
  "Georgia",
  "Germany",
  "Ghana",
  "Hong Kong",
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
  "Sweden",
  "Taiwan",
  "Thailand",
  "Turkey",
  "Ukraine",
  "United States"
)

mergeLength <- function(frame, country_codes, countries, columns) {
  base <- data.frame(V2=country_codes)
  coolFrame <- frame[frame$V2 %in% country_codes,]
  for (column in columns) {
    temp <- setNames(
      aggregate(coolFrame[,c("V2", column)][[column]], FUN=length, by=list(coolFrame$V2, coolFrame[[column]])),
      c("V2", "x", column))
    base = merge(x = base, y = temp, all.y = TRUE)
  }
  base <- merge(base, data.frame(V2=country_codes, country=countries))
  base
}

# PUT YOUR COLUMNS HERE
columns <- c("V4", "V5", "V6", "V56")

merged <- mergeLength(WV6_Data_R, country_codes, countries, columns)

# write.csv(MyData, file = "MyData.csv") 
# http://rprogramming.net/write-csv-in-r/
