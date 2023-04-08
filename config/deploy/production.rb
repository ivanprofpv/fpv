server "91.200.84.18", user: "deploy", roles: %w{app db web}, primary: true
set :rail_env, :production

 set :ssh_options, {
   keys: %w(/home/ivan/.ssh/id_rsa),
   forward_agent: true,
   auth_methods: %w(publickey password)
 }
