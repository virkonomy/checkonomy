# Checkonomy

Checkonomy is automated end-to-end testing script written in Elixir using Phantomjs as webdriver in the background.

Erlang VM make it possible to run all test simultaneously without waiting too long.

To run the test simply run `mix test`.

With current active market, this is the estimated count of endpoint we test:

Public API (101 endpoints)
- summaries 1 
- depth 1 x 33
- trades 1 x 33
- ticker 1 x 33
- market_info 1

Private API (7 endpoints)
- getinfo
- trans_history
- open_orders
- trade
- trade_history
- cancel_order
- get_orders




## Scope

The priority of the scope is to perform health check to all known endpoints. Ensure the link return 200 http response and try to parse the json return when its supposed to be.

We gradually built behavioural test, such as accessing private endpoint using credentials and try to perform trade.

We introduce Hound, wrapper for phantomjs as webdriver to simulate user using browser.

There are 3 testing files so far covering 3 parts

### Public API

Script location:

`/test/public_api_test.exs`

Coverage:
All enpoint listed in `https://exchange.tokenomy.com/help/api` public api section.

Method:
We take all active pairs from `market_info` endpoint and perform request to get `depth`, `trades`, and `ticker`

All result must return 200 and can be parsed into json object.


### Private API

Script location:

`/test/private_api_test.exs`

Coverage:
All enpoint listed in `https://exchange.tokenomy.com/help/api` private api section.

Method:
We use access key and secret key from real account to test all private endpoint using api.

All result must return 200 and can be parsed into json object.


### Public Web Page

Script location:

`/test/public_web_pages_test.exs`

Coverage:
- www.tokenomy.com
- exchange.tokenomy.com
- launchpad.tokenomy.com


Method:
Open the page using hound and check the title of the page.

More behavioural test need to be added in the future.


## Installation

- ensure you have erlang and elixir installed on your machine. 

- install phantomjs in your machine

- clone this repo, `cd` into directory and install dependency using `mix deps.get`

- ensure phantom web driver is running by calling `phantomjs --wd`

you can see something similar like this:


		[INFO  - 2019-04-08T23:03:19.817Z] GhostDriver - Main - running on port 8910



- run `mix test`



- virkonomy -
arif@tokenomy.com