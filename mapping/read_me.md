Everyone loves a good map!  Here's a sample adjustable map made in Tableau using custom shapefiles, along with the underlying data and steps taken to build it.

## Finished Product:

[Adjustable Map of NC and CA 2018 State Legislative Results](https://public.tableau.com/profile/anna.gilbert1179#!/vizhome/AKGSelectStatesSDandHD2018Results/SelectStatesSDHD2018Results?publish=yes)

## Data to Download:

[Census Shapefile Data Source](https://www.census.gov/geo/maps-data/data/cbf/cbf_sld.html)

[NC Election Results](https://er.ncsbe.gov/?election_dt=11/06/2018&county_id=0&office=FED&contest=0)

[CA Election Results](https://www.sos.ca.gov/elections/prior-elections/statewide-election-results/general-election-november-6-2018/statement-vote/)

[Cleaned Data](https://drive.google.com/file/d/1vle5loMjQz9iIU1wtRlwpFkyG0v92cJt/view?usp=sharing)

Tableau Public (free!)

## Tableau Step by Step:

# Data set up:

1. Add the Voting Data excel spreadsheet to your Tableau workbook
2. Add census SD (Senate District) shapefiles - such as cb_2017_37_sldu_500k
.. Tip: Make sure these are unzipped first.
3. Add census HD (House District) shapefiles - such as cb_2017_37_sldl_500k
.. Tip: The difference between HD and SD is the "u" and "l" meaning "upper district" and "lower district"
4. Drag the "full data set" tab of the NC Voting Data excel file to the center box
5. Drag the cb_2017_37_sldu_500k.shp to the data workspace
6. Left join with the full_data_set on the following: Sldlst (district),  Lsad (district level) and State fips
7. Repeat for all other shapefiles.  
.. Tip: If you're using mulitple states you can join those shapefiles one at a time, or merge them into a master national shapefile with R or Python.

# Map Framework Build:

1. Map Lat (Rows) and Long (Columns) by dragging or double clicking
2. Drag Geometry (in the measures) to the level of detail - you can use the geometry from either the house or senate file
3. Drag District (in the dimensions) to the level of details
4. Drag a measure, such as total Democratic Voters to color in the marks card

# Parameters & Calculated Fields:

1. Create parameters for SD vs HD, States used and Metrics used.  Call each "Choose Your ______" and drag this onto the viewing pane.
2. Create calculated fields to match the parameters such as the Metric Pivot which can read like the following:

`if [Choose a Metric] = 'Democratic Votes' then [Democratic Votes]
elseif [Choose a Metric] = 'Republican Votes' then [Republican Votes]
else [Total Votes]
end`

3. Switch the shade metric to use the calculated fields, replace the existing geographic with the calculated field
4. Add a filter by District level and use a condition formula filter: [District level] = [Choose a District Level]



Good Luck & Enjoy!
