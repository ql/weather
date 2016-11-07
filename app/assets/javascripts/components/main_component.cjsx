module.exports = MainComponent = React.createClass
  getInitialState: ->
    token: null,
    message: null,
    fields: [],
    user: {
      email: "",
      password: ""
    }
    newUser: {
      name: "",
      email: "",
      password: "",
      password_confirmation: ""
    },
    newField: {
      name: "",
      boundary: ""
    }


  setNewUser: (attr) ->
    (e) =>
      newUser = @state.newUser
      newUser[attr] = e.target.value
      @setState newUser: newUser, message: null

  setUser: (attr) ->
    (e) =>
      user = @state.user
      user[attr] = e.target.value
      @setState user: user, message: null

  setField: (attr) ->
    (e) =>
      field = @state.newField
      field[attr] = e.target.value
      @setState newField: field, message: null

  setBoundary: (e) ->
      field = @state.newField
      field.boundary = JSON.parse(e.target.value)
      @setState newField: field, message: null


  submitNewUser: (e) ->
    e.preventDefault()
    if (@state.newUser.password == @state.newUser.password_confirmation)
      $.post('/users/sign_up',
        {user: @state.newUser}
        @userCreated,
        'json'
      )
    else
      @showMessage("Пароли не совпадают")

  userCreated: (d) ->
    @showMessage("Вы успешно зарегистрировались и можете войти с указанным логином и паролем")
    true

  userNotCreated: (d) ->
    console.log(d)
    true

  logIn: (e) ->
    e.preventDefault()
    $.post('/users/sign_in',
      {session: @state.user}
      @loggedIn,
      'json'
    )

  logIn: (e) ->
    e.preventDefault()
    $.post('/users/sign_in',
      {session: @state.user}
      @loggedIn,
      'json'
    )

  loggedIn: (d) ->
    @setState token: d.token
    @showMessage("Здравствуйте, #{d.name}")
    @fetchFields()

  fetchFields: () ->
    $.ajax(
      url: '/fields',
      method: 'get',
      headers: {'Authorization': 'Token token="'+@state.token + '"'},
      dataType: 'json',
      success: (d) =>
        console.log(d)
        @setState fields: d
    )

  addField: (e) ->
    e.preventDefault()
    $.ajax(
      url: '/fields.json',
      method: 'post',
      dataType: 'json',
      data: JSON.stringify({field: @state.newField}),
      contentType: 'application/json',
      headers: {'Authorization': 'Token token="'+@state.token + '"'},
      success: (d) =>
        @showMessage "Поле добавлено"
        @fetchFields()
    )


  showMessage: (m) ->
    @setState message: m

  signupForm: ->
    <form>
      <div className="row">
        <div className="four columns">
          <h4>Sign up</h4>
        </div>
      </div>
      <div className="row">
        <div className="four columns">
          <label htmlFor="name">Name</label>
          <input className="u-full-width" type="text" id="name" value={@state.newUser.name} onChange={@setNewUser('name')} />
        </div>
        <div className="four columns">
          <label htmlFor="email">Email</label>
          <input className="u-full-width" type="email" id="email" value={@state.newUser.email} onChange={@setNewUser('email')} />
        </div>
      </div>
      <div className="row">
        <div className="four columns">
          <label htmlFor="password1">Password</label>
          <input className="u-full-width" type="password" placeholder="test@mailbox.com" id="password1" value={@state.newUser.password} onChange={@setNewUser('password')} />
        </div>
        <div className="four columns">
          <label htmlFor="password2">Password repeat</label>
          <input className="u-full-width" type="password" id="password2" value={@state.newUser.password_confirmation} onChange={@setNewUser('password_confirmation')} />
        </div>
        <div className="four columns">
          <input className="button-primary" type="submit" value="Signup" style={{"marginTop": "10%"}} onClick={@submitNewUser} />
        </div>
      </div>
    </form>

  loginForm: ->
    <form>
      <div className="row">
        <div className="four columns">
          <h4>Login</h4>
        </div>
      </div>
      <div className="row">
        <div className="four columns">
          <label htmlFor="emailInput">Email</label>
          <input className="u-full-width" type="email" placeholder="test@mailbox.com" id="emailInput"  onChange={@setUser('email')} />
        </div>
        <div className="four columns">
          <label htmlFor="passwordInput">Password</label>
          <input className="u-full-width" type="password" id="passwordInput" onChange={@setUser('password')} />
        </div>
        <div className="four columns">
          <input className="button-primary" type="submit" value="Login" style={{"marginTop": "10%"}}  onClick={@logIn} />
        </div>
      </div>
    </form>

  renderFields: ->
    <form>
      <div className="row">
        <div className="three columns">
          <h5>Ваши поля</h5>
          <ol>
            { for field in @state.fields
              <li><a href="#"> {field.name} </a></li>
            }
          </ol>
          { (@state.fields == []) && "У вас нету полей"}

          <h5>Добавить</h5>
          <label for="fieldName">Название поля</label>
          <input className="u-full-width" type="text"  id="fieldName" onChange={@setField('name')} />

          <label for="fieldBoundary">Граница поля (GeoJSON)</label>
          <textarea className="u-full-width" type="text"  id="fieldBoundar" onChange={@setBoundary} />
          <input className="button-primary" type="submit" value="Добавить" onClick={@addField} />
        </div>
        <div className="nine columns">
          <h5>На карте</h5>
          <div id="map"></div>
        </div>
      </div>
    </form>


  render: ->
    <div className="container">
      { @state.message &&
        <div className="row">
          <div className="four columns">
            <h4>{ @state.message }</h4>
          </div>
        </div>
      }
      { (!@state.token) &&
      <div>
        { @loginForm() }
        { @signupForm() }
      </div>
      }

      { @state.token &&
        @renderFields()
      }
    </div>
