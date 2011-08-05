Example
-------

    MyAppConfig = StaticConfig.build do
      first do
        env_yaml 'my_app_config'
        file Rails.root.join('config/my_app.yml'), :section => Rails.env
      end
      env 'MY_APP'
    end

Now you have an object MyAppConfig that you can use anywhere.

For instance, if your `config/my_app.yml` looks like this:

    development:
      user:
        selected:
          color: orange

You could get `orange` by doing this:

    MyAppConfig.user.selected.color

You could override it at runtime by setting the environment variable
`MY_APP_USER_SELECTED_COLOR`.

You can also override the entire `config/my_app.yml` file by storing
some yaml in an environment variable called `my_app_config`.

This library is rails-friendly, so in development mode it will
reload the configuration on each request.
