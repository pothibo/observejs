class ObserveJS
  attributeName: 'as'

  constructor: ->
    @cache = {}

  initialize: =>
    event = new CustomEvent('observejs:loaded')
    document.dispatchEvent(event)

  isDOM: (el) ->
    el instanceof HTMLDocument ||
    el instanceof HTMLElement

  bind: (name, kls) =>
    @cache[name] = kls

    kls.prototype.template = (selector) ->
      tmpl = @element().querySelector("template[for='#{name}']")
      unless tmpl?
        throw "Template Error: Couldn't find a template matching #{name}"
        return
      (tmpl.content || tmpl).querySelector(selector).cloneNode(true)

window.ObserveJS = new ObserveJS()
