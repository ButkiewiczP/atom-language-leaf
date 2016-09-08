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

    expect(tokens[0]).toEqual value: '#', scopes: ['text.html.leaf', 'meta.variable.leaf', 'keyword.control.leaf']
    expect(tokens[1]).toEqual value: '(', scopes: ['text.html.leaf', 'meta.variable.leaf', 'constant.other.begin.leaf']
    expect(tokens[2]).toEqual value: 'aRandomVariableName', scopes: ['text.html.leaf', 'meta.variable.leaf', 'string.quoted.double.html']
    expect(tokens[3]).toEqual value: ')', scopes: ['text.html.leaf', 'meta.variable.leaf', 'constant.other.end.leaf']

  it 'parses tags', ->
    {tokens} = grammar.tokenizeLine("##loop(friends, \"friend\") {")

    expect(tokens[0]).toEqual value: '##', scopes: ['text.html.leaf', 'meta.tag.leaf', 'keyword.control.leaf']
    expect(tokens[1]).toEqual value: 'loop', scopes: ['text.html.leaf', 'meta.tag.leaf', 'entity.name.tag.leaf']
    expect(tokens[2]).toEqual value: '(', scopes: ['text.html.leaf', 'meta.tag.leaf', 'constant.other.begin.leaf']
    expect(tokens[3]).toEqual value: 'friends, "friend"', scopes: ['text.html.leaf', 'meta.tag.leaf', 'string.quoted.double.html']
    expect(tokens[4]).toEqual value: ')', scopes: ['text.html.leaf', 'meta.tag.leaf', 'constant.other.end.leaf']
