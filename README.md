# Kvs

HTTP key-value storage

## Installation

    mix deps.get

## Start

    iex -S mix

## Test

    curl -X GET http://localhost:4000/abc -i
    curl -X DELETE http://localhost:4000/abc -i
    curl -X POST --data "123" http://localhost:4000/abc
    curl -X PUT --data "123" http://localhost:4000/abc
