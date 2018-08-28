#!/bin/sh

echo ~~~~ ~~~~ Interfaces ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
solc ../Interfaces/*.sol | grep error

echo ~~~~ ~~~~ Helpers    ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
solc ../Helpers/*.sol | grep error

echo ~~~~ ~~~~ DefaultImplementations    ~~~~ ~~~~ ~~~~ ~~~~
solc ../DefaultImplementations/*.sol | grep error