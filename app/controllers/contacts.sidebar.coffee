Spine   = require('spine')
Contact = require('models/contact')
List    = require('spine/lib/list')
$       = Spine.$

class Sidebar extends Spine.Controller
  className: 'sidebar'
    
  elements:
    '.items': 'items'
    'input': 'search'
    
  events:
    'keyup input': 'filter'
    'click footer button': 'create'
      
  constructor: ->
    super
    @html require('views/sidebar')()
    
    @list = new List
      el: @items, 
      template: require('views/item'), 
      selectFirst: false

    @list.bind 'change', @change
    @list.bind 'click', @change

    @active (params) -> 
      @list.change(Contact.find(params.id))
    
    Contact.bind('refresh change', @render)
  
  filter: ->
    @query = @search.val()
	alert ""+ "vinod1" +@query
    @render()
    
  render: =>
    contacts = Contact.filter(@query)
    @list.render(contacts)
    
  change: (item) =>
    @navigate '/contacts',item.id
    

  create: ->
    item = Contact.create()
    @navigate('/contacts',item.id, 'edit')

    
module.exports = Sidebar