
=begin
rvm '/srv/redmine' do
  rvm install 'ruby-1.9.3'
  rvm use 'ruby-1.9.3'
  rvm gemset create 'redmine'
  bundle install
end
=end


actions :install


attribute :use, :kind_of => String, :name_attribute => true
#attribute :command, :kind_of => String
#attribute :process_name, :kind_of => String, :default => '%(program_name)s'
#attribute :numprocs, :kind_of => Integer, :default => 1
#attribute :numprocs_start, :kind_of => Integer, :default => 0
#attribute :priority, :kind_of => Integer, :default => 999
#attribute :autostart, :kind_of => [TrueClass, FalseClass], :default => true
#attribute :autorestart, :kind_of => [String, Symbol, TrueClass, FalseClass], :default => :unexpected
#attribute :startsecs, :kind_of => Integer, :default => 1
#attribute :startretries, :kind_of => Integer, :default => 3
#attribute :exitcodes, :kind_of => Array, :default => [0, 2]
#attribute :stopsignal, :kind_of => [String, Symbol], :default => :TERM
#attribute :stopwaitsecs, :kind_of => Integer, :default => 10

def initialize(*args)
  super
  @action = :install
  @cmd_stack = []
end


def rvm(*args)
  Chef::Log.info("[rvm] #{args.join(', ')}")
  @cmd_stack.reverse.each do |arg|
    Chef::Log.info("  [#{arg}]")
  end
  @cmd_stack.clear
  nil
end


def bundle(*args)
  Chef::Log.info("[bundle] #{args.join(', ')}")
  @cmd_stack.clear
  nil
end


%w{ install gemset create use }.each do |subcommand|
  define_method(subcommand) do |*args|
    case args.length
    when 0
    when 1
      arg = args.first
      validate({:arg => arg}, :arg => {:kind_of => [String, Integer, self.class]})
      unless self.equal? arg
        @cmd_stack << arg
      end
    else
      raise "Too many argument at '#{subcommand}'"
    end
    @cmd_stack << subcommand.to_sym
    self
  end
end

private







