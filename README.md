# PRTG-Get-Joan-Status

If you are owner of [JOAN devices](https://getjoan.com/products/) and use your own on-premise management server, this script may come in handy :)

Script does return state, battery level, temperature and wifi signal level of the device as PRTG custom EXE/XML sensor.

## Prerequisites

- use at least one Joan device
- on-premise management server
- create API account on server

You need to fill these variables in script before use:

- $hostURI = 'http://my.joanserver.com:8081'
- $httpsURI = 'https://my.joanserver.com'
- $api_key = '123aaa456bbb'
- $api_secret = 'someveryrandomstring'

## Usage

Create new Custom EXE/XML sensor with parameter -deviceid
