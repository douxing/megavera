# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :rails_env, "production"
set :user, "ubuntu"
set :deploy_to, "/home/#{fetch(:user)}/www/#{fetch(:application)}"
set :servername, "54.69.163.218"

role :app, "#{fetch(:user)}@#{fetch(:servername)}"
role :web, "#{fetch(:user)}@#{fetch(:servername)}"
role :db, "#{fetch(:user)}@#{fetch(:servername)}"


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

#server fetch(:servername), port: 22, roles: %w{web app db}


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#set :ssh_options, {
#  keys: %w(/home/shwbai/aws.pem),
#  forward_agent: false,
#  auth_methods: %w(publickey)
#}
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
