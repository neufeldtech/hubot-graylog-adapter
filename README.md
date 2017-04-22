hubot-graylog-adapter
================
[![npm version](https://badge.fury.io/js/hubot-graylog-adapter.svg)](https://badge.fury.io/js/hubot-graylog-adapter)
[![Build Status](https://travis-ci.org/neufeldtech/hubot-graylog-adapter.svg?branch=master)](https://travis-ci.org/neufeldtech/hubot-graylog-adapter)

Graylog logging adapter for Hubot

## Installation

* Run the ```npm install``` command

```
npm install hubot-graylog-adapter --save
```

* Add **hubot-graylog-adapter** to the array in your external-scripts.json file.

```
[
  "hubot-graylog-adapter"
]
```
 
 * Configure environment variables

| Environment Variable              | Required | Description                                             | Example             |
|-----------------------------------|----------|---------------------------------------------------------|---------------------|
| HUBOT_GRAYLOG_ADAPTER_HOSTNAME    | Yes      | Hostname/IP of Graylog server                           | graylog.example.com |
| HUBOT_GRAYLOG_ADAPTER_PORT        | no       | GELF port number of Graylog server (default: 12201)     | 12201               |
| HUBOT_GRAYLOG_ADAPTER_FACILITY    | no       | 'facility' attribute for log messages (default: hubot)  | hubot               |
| HUBOT_GRAYLOG_ADAPTER_APPNAME     | no       | 'app' attribute for log messages (default: hubot)       | hubot               |
| HUBOT_GRAYLOG_ADAPTER_ENVIRONMENT | no       | 'env' attribute for log messages (default: development) | development         |
| HUBOT_LOG_LEVEL                   | no       | Hubot logging level (default: info)                     | info                |

## Usage

Use the `robot.logger` methods in your hubot scripting, and your messages will be sent to the console as well as Graylog.
```
  module.exports = (robot) ->
   robot.hear /knock knock/i, (msg) ->
     robot.logger.info "Someone is telling a joke!"
     msg.send "Who is there?"
```
Supported `robot.logger` levels:
```
robot.logger.emergency "Graylog logger!"
robot.logger.alert "Graylog logger!"
robot.logger.critical "Graylog logger!"
robot.logger.error "Graylog logger!"
robot.logger.warning "Graylog logger!"
robot.logger.notice "Graylog logger!"
robot.logger.info "Graylog logger!"
robot.logger.debug "Graylog logger!"
```

## Tests

To run the tests, run the below command. If you are contributing, please add appropriate tests before submitting a pull request.

```
npm test
```

## Acknowledgements
This project makes use of:
- [gelf-pro](https://github.com/kkamkou/node-gelf-pro)
- [momentjs](https://momentjs.com/)

