# Kvs

HTTP key-value storage

## Installation

    mix deps.get

## Start

    iex -S mix

## Test

    #select
    curl -X GET http://localhost:4000/abc -i
    
    #insert/update
    curl -X PUT --data "123" http://localhost:4000/abc
    #insert with TTL
    curl -X POST -F 'value=123' -F 'ttl=100' http://localhost:4000/abc
    
    #delete
    curl -X DELETE http://localhost:4000/abc -i
