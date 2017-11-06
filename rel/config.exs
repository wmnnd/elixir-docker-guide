use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"WQqW]YPYmjsoNxBuzQ`koW2${8Pv~m{w>nH42hT>QqR~cE=qYdA@:0{RVr/i`@>W"
end

release :clock do
  set version: current_version(:clock)
  set applications: [
    :runtime_tools
  ]
end
