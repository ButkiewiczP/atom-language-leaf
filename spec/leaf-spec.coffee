describe 'Leaf grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-leaf')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.html.leaf')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'text.html.leaf'

  it 'parses variables', ->
    {tokens} = grammar.tokenizeLine("#(aRandomVariableName)")

    expect(tokens[0]).toEqual value: '#', scopes: ['text.html.leaf', 'meta.variable.leaf', 'operator.control.leaf']
    expect(tokens[1]).toEqual value: '(', scopes: ['text.html.leaf', 'meta.variable.leaf', 'begin.operator.control.leaf']
    expect(tokens[2]).toEqual value: 'aRandomVariableName', scopes: ['text.html.leaf', 'meta.variable.leaf', 'entity.name.variable.leaf']
    expect(tokens[3]).toEqual value: ')', scopes: ['text.html.leaf', 'meta.variable.leaf', 'end.operator.control.leaf']

  it 'parses tags', ->
    {tokens} = grammar.tokenizeLine("##loop(friends, \"friend\") {")

    expect(tokens[0]).toEqual value: '##', scopes: ['text.html.leaf', 'meta.tag.leaf', 'operator.control.leaf']
    expect(tokens[1]).toEqual value: 'loop', scopes: ['text.html.leaf', 'meta.tag.leaf', 'entity.name.tag.leaf']
    expect(tokens[2]).toEqual value: '(', scopes: ['text.html.leaf', 'meta.tag.leaf', 'begin.operator.control.leaf']
    expect(tokens[3]).toEqual value: 'friends, "friend"', scopes: ['text.html.leaf', 'meta.tag.leaf', 'entity.parameters.tag.leaf']
    expect(tokens[4]).toEqual value: ')', scopes: ['text.html.leaf', 'meta.tag.leaf', 'end.operator.control.leaf']
