class Dashing.Fadelist extends Dashing.Widget
  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()

  onData: ->
      $(@node).find('ol').fadeOut().show("fast")
      $(@node).find('ul').fadeOut().show("fast")