Kind = require('graphql/language').Kind
GraphQLMoment = require('../lib/graphql-moment')()

describe 'GraphQLMoment', ->
  describe 'serialize', ->
    it 'should error when serializing a string value', (done) ->
      str = '2015-07-24T10:56:42.744Z'
      expect(GraphQLMoment.serialize.bind(GraphQLMoment, str)).to.throw /not an instance of Date/
      done()
      return
    it 'should error when serializing a string value', (done) ->
      date = new Date('invalid')
      expect(GraphQLMoment.serialize.bind(GraphQLMoment, date)).to.throw /an invalid Date/
      done()
      return
    it 'should serialize a date value', (done) ->
      str = '2015-07-24T10:56:42.744Z'
      date = new Date(str)
      expect(GraphQLMoment.serialize(date)).to.equal date.toJSON()
      done()
      return
    return
  describe 'parseValue', ->
    it 'should error when serializing a string value', (done) ->
      str = 'invalid'
      expect(GraphQLMoment.parseValue.bind(GraphQLMoment, str)).to.throw /an invalid Date/
      done()
      return
    it 'should parse a value to date', (done) ->
      str = '2015-07-24T10:56:42.744Z'
      date = GraphQLMoment.parseValue(str)
      expect(date).to.be.an.instanceOf Date
      expect(date.toJSON()).to.equal str
      done()
      return
    return
  describe 'parseLiteral', ->
    it 'should error when parsing a ast int', (done) ->
      ast = kind: Kind.INT
      expect(GraphQLMoment.parseLiteral.bind(GraphQLMoment, ast)).to.throw /only parse strings/
      done()
      return
    it 'should error when parsing ast w/ invalid value', (done) ->
      ast =
        kind: Kind.STRING
        value: 'invalid'
      expect(GraphQLMoment.parseLiteral.bind(GraphQLMoment, ast)).to.throw /Invalid date$/
      done()
      return
    it 'should error when parsing ast w/ invalid value format', (done) ->
      ast =
        kind: Kind.STRING
        value: '2015-07-24T10:56:42'
      expect(GraphQLMoment.parseLiteral.bind(GraphQLMoment, ast)).to.throw /Invalid date format/
      done()
      return
    it 'should parse a ast literal', (done) ->
      ast =
        kind: Kind.STRING
        value: '2015-07-24T10:56:42.744Z'
      date = GraphQLMoment.parseLiteral(ast)
      expect(date).to.be.an.instanceOf Date
      expect(date.toJSON()).to.equal ast.value
      done()
      return
    return
  return

# ---
# generated by js2coffee 2.2.0
