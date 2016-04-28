Template.paginationBar.helpers
  pages: (count) ->
    current = parseInt(FlowRouter.getQueryParam('page')) or 0
    total = Math.ceil(Counts.get(count)/this.itemsPerPage)
    paginationBar(this.window, total, current)
  pageNumber: -> this + 1
  selected: ->
    current = parseInt(FlowRouter.getQueryParam('page')) or 0
    if parseInt(this) == current then 'active' else ''
  showMinus: ->
    current = parseInt(FlowRouter.getQueryParam('page')) or 0
    current != 0
  showPlus: (count) ->
    current = parseInt(FlowRouter.getQueryParam('page')) or 0
    total = Math.ceil(Counts.get(count)/this.itemsPerPage)
    all = paginationBar(this.window, total, current)
    current != all[-1..][0]

Template.paginationBar.events
  'click .first': (e, t) ->
    e.preventDefault()
    FlowRouter.setQueryParams({page: 0})
  'click .last': (e, t) ->
    e.preventDefault()
    total = Math.ceil(Counts.get(this.count)/this.itemsPerPage)
    FlowRouter.setQueryParams({page: total-1})
  'click .plus': (e, t) ->
    e.preventDefault()
    current = parseInt(FlowRouter.getQueryParam('page')) or 0
    FlowRouter.setQueryParams({page: current + 1})
  'click .minus': (e, t) ->
    e.preventDefault()
    current = parseInt(FlowRouter.getQueryParam('page')) or 0
    FlowRouter.setQueryParams({page: current - 1})
  'click .change-page': (e, t) ->
    e.preventDefault()
    page = parseInt e.target.getAttribute 'data-page'
    FlowRouter.setQueryParams({page: page})

paginationBar = (pwindow, total, current) ->
  middle = Math.ceil(pwindow/2)
  ini = current - middle
  end = current + middle
  if ini < 0
    ini = 0
    if total > pwindow
      end = pwindow
    else
      end = total
  else if end >= total
    end = total
    ini = end - pwindow
    if ini < 0 then ini = 0

  [ini...end]
