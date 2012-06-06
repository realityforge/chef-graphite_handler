if node['chef_client']['handler']['graphite']['host'] && node['chef_client']['handler']['graphite']['port']
  include_recipe "chef_handler"

  gem_package "simple-graphite" do
    action :nothing
  end.run_action(:install)

  cookbook_file "#{Chef::Config[:file_cache_path]}/chef-handler-graphite.rb" do
    source "chef-handler-graphite.rb"
    mode "0600"
  end

  chef_handler "GraphiteReporting" do
    source "#{Chef::Config[:file_cache_path]}/chef-handler-graphite.rb"
    arguments [
                :metric_key => node['chef_client']['handler']['graphite']['prefix'],
                :graphite_host => node['chef_client']['handler']['graphite']['host'],
                :graphite_port => node['chef_client']['handler']['graphite']['port']
              ]
    action :enable
  end
end
