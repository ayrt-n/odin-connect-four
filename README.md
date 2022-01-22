# Ruby Connect Four

## Overview

Project for The Odin Project (https://www.theodinproject.com/) to recreate the game Connect Four in ruby played on the command line, using Test Driven Development.

## How to use

The game can be run from the command line by simply running:

```
$ ruby lib/main.rb
```

Further instructions provided within the command line.

Easiest way to play is live on replit: https://replit.com/@ayrtonomics/odin-connect-four?v=1

## Key Topics

This project was part of the 'Testing Ruby with RSpec' section of the course.

As such, the game was fully developed using TDD and the red-green-refactor process.

Number of different testing techniques learned and utilized throughout the development process, including:

- Using let statements and before blocks to reduce repetition across similar tests
- Using doubles and instance_doubles to isolate tests from collaborating classes and reduce dependencies
- Using stubs and mocks to fake certain method sends, impose arguments and returns values for certain method sends, and confirm that methods are being sent the correct number of times (while not actually calling the method itself)
