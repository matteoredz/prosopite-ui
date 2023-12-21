# ProsopiteUI
A simple UI for [Prosopite](https://github.com/charkost/prosopite), the N+1 detector. It parses the report, automatically merges duplicates, and helps keeping track of resolved detections.

## Prerequisites
- Docker and Docker Compose must be installed. ([Here](https://gist.github.com/matteoredz/80131bbaf823303661502d5210f2c941) an how-to for MacOS)
- The log file must be a `.zip` without password protection

## Setup
- Clone this repository
- Run `docker-compose up --build` from the root of this app
- Visit [http://0.0.0.0:3000/reports](http://0.0.0.0:3000/reports)

## Import a new report

### From the UI
- [http://0.0.0.0:3000/reports/new](http://0.0.0.0:3000/reports/new)

When importing a report from the UI, it is processed async through ActiveJob. You can follow the progress [here](http://0.0.0.0:3000/good-job/jobs).

### From the Rails Console
```shell
bin/rails 'prosopite:import[https://site.com/prosopite.log.zip]'
```
