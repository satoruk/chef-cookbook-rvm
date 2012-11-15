

action :install do
  Chef::Log.info 'rvm install'
end

def initialize(*args)
  super
  Chef::Log.info('Something bad happened and I want to stop')
end



