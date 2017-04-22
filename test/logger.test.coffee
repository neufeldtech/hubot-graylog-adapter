expect = require('chai').expect

Helper = require('hubot-test-helper')

describe 'Logger hostname and port configured', ->
  beforeEach ->
    process.env.HUBOT_GRAYLOG_ADAPTER_HOSTNAME = "localhost"
    process.env.HUBOT_GRAYLOG_ADAPTER_PORT = "9000"
    helper = new Helper('../scripts/logger.coffee')
    @room = helper.createRoom(httpd: false)
  describe 'upon init', ->
    it 'should contain correct hostname', ->
      expect(@room.robot.logger.config.adapterOptions.host).to.equal('localhost')
    it 'should contain correct port', ->
      expect(@room.robot.logger.config.adapterOptions.port).to.equal('9000')