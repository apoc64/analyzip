# AnalyZip

This app takes data related to geographic entities and displays that data from the IRS and County Health Rankings alongside Google Maps.

## This app uses:
Rails 5.2

Ruby 2.4.1

ES6

Google Maps

## Getting Started
Clone this repo. It contains large .csv files which may require additional time.
> bundle install

> bundle

> rake db:create

> rake db:migrate

> rake db:seed

The seed file will create over 30,000 rows over 3 tables (States, Counties, Zips). This will take several minutes or more. Puts statements in the seed will give you feedback as to the seed's success including statements on the successful creation of each state, and total number of each entity created - 51 states(DC included), 27,000 + zip codes, 2800 + counties.

This app uses Rails 5.2 credentials. You will need a Google API key for Maps, and a client_id and client secret for OAuth. You can obtain these from Google. To add them to the Rails project, you must edit the encrypted file credentials.yml.enc which uses master.key to decrypt. To edit the credentials file in Atom, run

> EDITOR="atom --wait" rails credentials:edit

or change appropriately depending on your text editor

To run this project locally on localhost:3000, run
> rails s

To run the test suite, run
> rspec

## Data Sources
https://www.irs.gov/statistics/soi-tax-stats-individual-income-tax-statistics-zip-code-data-soi
The app currently uses 2015 data. Once newer data becomes available, the csv may be changeds out and and column names adjusted appropriatetely through database migration . 
http://www.countyhealthrankings.org/explore-health-rankings/rankings-data-documentation
The County Health Rankings data lists 2018 as its publication date. 

## Deployment
This app is currently deployed at: https://analyzip.herokuapp.com/
