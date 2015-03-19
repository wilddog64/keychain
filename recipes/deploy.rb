# keychain::deploy script will deploy keychain script
file_cache_path = Chef::Config[:file_cache_path]
git_app_workspace = File.join( file_cache_path, 'keychain' )
git git_app_workspace do
  repository node['keychain']['git']['repo']
  action :sync
end
