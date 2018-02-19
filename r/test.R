country_codes = c(
	32,	# Argentina
	36,	# Australia
	76,	# Brazil
	170,	# Colombia
	196,	# Cyprus
	152,	# Chile
	156,	# China
	818,	# Egypt
	268,	# Georgia
	276,	# Germany
	288,	# Ghana
	344,	# Hong Kong
	356,	# India
	368,	# Iraq
	392,	# Japan
	400,	# Jordan
	458,	# Malaysia
	484,	# Mexico
	504,	# Morocco
	752,	# Sweden
	616,	# Poland
	840,	# United States
	792,	# Turkey
	158,	# Taiwan
	528,	# Netherlands
	764,	# Thailand
	804,	# Ukraine
	554,	# New Zealand
	643,	# Russia
	710	# South Africa
)

countries = c(
	"Argentina",
	"Australia",
	"Brazil",
	"Colombia",
	"Cyprus",
	"Chile",
	"China",
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
	"Sweden",
	"Poland",
	"United States",
	"Turkey",
	"Taiwan",
	"Netherlands",
	"Thailand",
	"Ukraine",
	"New Zealand",
	"Russia",
	"South Africa"
)

varMean <- function(min, max, inverted = TRUE) {
	function(values) {
		sum = 0
		count = 0
		for (value in values) {
			if (value >= min && value <= max) {
				sum = sum + value
				count = count + 1
			}
		}
		norm = ((sum / count) - min) / (max - min)
		if (inverted) {
			norm = 1 - norm
		}
		norm
	}
}

varMedian <- function(min, max) {
	function(values) {
		round(median(Filter(function(x) x >= min && x <= max, values)))
	}
}

# PUT YOUR COLUMNS HERE
# columns <- data.frame(column=character(), min=integer(), max=integer(), inverted=logical(), stringsAsFactors=FALSE)
# columns[nrow(columns) + 1,] = c("V4", 1, 4, TRUE)
# columns[nrow(columns) + 1,] = c("V5", 1, 4, TRUE)
# columns[nrow(columns) + 1,] = c("V6", 1, 4, TRUE)

mergeColumnsMean <- function(frame, country_codes, countries, columns) {
	base <- data.frame(V2=country_codes, country=countries)
	
	for (i in 1:nrow(columns)) {
		column = columns[i, "column"]
		min = strtoi(columns[i, "min"])
		max = strtoi(columns[i, "max"])
		inverted = columns[i, "inverted"]
		temp <- setNames(
			aggregate(frame[,c("V2", column)][[column]], FUN=varMean(min, max, inverted), by=list(frame$V2)),
			c("V2", column))
		base = merge(base, temp)
	}

	base
}

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

#mergeColumns (WV6_Data_R, country_codes, countries, columns)

merged <- mergeLength(WV6_Data_R, country_codes, countries, columns)

test5 <- setNames(
	aggregate(WV6_Data_R[,c("V2", "V4")]$V4, FUN=length, by=list(WV6_Data_R$V2, WV6_Data_R$V4)),
	c("V2", "x", "V4"))
#test5

#head(WV6_Data_R[c("V2", "V4")])
