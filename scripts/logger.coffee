# Description:
#   Provides a logging adapter for sending robot.logger logs to Graylog
#
# Configuration:
#   HUBOT_GRAYLOG_ADAPTER_HOSTNAME - Hostname/IP of Graylog server
#   HUBOT_GRAYLOG_ADAPTER_PORT - GELF port number of Graylog server (default: 12201)
#   HUBOT_GRAYLOG_ADAPTER_FACILITY - 'facility' attribute for log messages (default: hubot)
#   HUBOT_GRAYLOG_ADAPTER_APPNAME - 'app' attribute for log messages (default: hubot)
#   HUBOT_GRAYLOG_ADAPTER_ENVIRONMENT - 'env' attribute for log messages (default: development)
#
# Notes:
#   robot.logger.emergency "Emergency!!!!!"
#   robot.logger.alert "Alert!"
#   robot.logger.critical "Critical!"
#   robot.logger.error "Error!"
#   robot.logger.warning "Warning..."
#   robot.logger.notice "Notice"
#   robot.logger.info "Info"
#   robot.logger.debug "Debugging"
#

graylogHost = process.env.HUBOT_GRAYLOG_ADAPTER_HOSTNAME
graylogPort = process.env.HUBOT_GRAYLOG_ADAPTER_PORT or 12201
facility = process.env.HUBOT_GRAYLOG_ADAPTER_FACILITY or 'hubot'
appName = process.env.HUBOT_GRAYLOG_ADAPTER_APPNAME or 'hubot'
appEnv = process.env.HUBOT_GRAYLOG_ADAPTER_ENVIRONMENT or 'development'
moment = require('moment')

levels = 
  emergency: 0
  alert: 1
  critical: 2
  error: 3
  warning: 4
  notice: 5
  info: 6
  debug: 7

date = ->
  (new moment).format()

module.exports = (robot) ->
  if !graylogHost or !graylogPort
    robot.logger.warning 'Graylog host and port not defined. Please set environment variables in order to log to Graylog'
  else
    robot.logger = require('gelf-pro')
    robot.logger.setConfig
      adapterOptions:
        host: graylogHost
        port: graylogPort
      fields:
        facility: facility
        app: appName
        env: appEnv
      filter: [ (message) ->
        return (message.level <= (levels[process.env.HUBOT_LOG_LEVEL] || levels['info']))
      ]
      broadcast: [ (message) ->
        # broadcasting to console
        console[if message.level > 3 then 'log' else 'error'] date(), message.short_message
        return
      ]
    robot.logger.debug "Hubot Graylog logger was loaded!"