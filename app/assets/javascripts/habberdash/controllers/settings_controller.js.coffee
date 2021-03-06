class Habberdash.SettingsController extends Habberdash.Modal

  events:
    'submit form': 'update'
    'tap .destroy': 'destroy'


  constructor: ->
    @attributes = {class: 'settings'}
    super({title: 'Dashboard Settings'})

    @html(@view('settings', Habberdash.config.dashboardAttributes()))
    @show()


  update: (e) ->
    e.preventDefault()
    form = $(e.target)
    params = form.serializeObject()

    dashboard = Habberdash.config.updateDashboard(params)
    if !dashboard.isValid() || !params['id']
      errors = dashboard.validate() || {}
      errors['id'] = "can't be blank, or is already taken" unless params['id']
      return @displayErrors(form, errors)

    @navigate("/#{dashboard.id}", false)
    @hide()


  destroy: (e) ->
    e.preventDefault()
    if Habberdash.config.dashboards().count() == 1
      alert("You can't delete your last dashboard.")
    else
      return unless confirm('Are you sure?')
      Habberdash.config.destroyDashboard()

    @navigate("/#{Habberdash.config.dashboard().id}")
