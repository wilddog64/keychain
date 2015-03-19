# keychain::deploy script will deploy keychain script
file_cache_path = Chef::Config[:file_cache_path]
git_app_workspace = File.join( file_cache_path, 'keychain' )
git git_app_workspace do
  repository node['keychain']['git']['repo']
  action :sync
  notifies :run, 'execute[make-keychain]', :immediately
  notifies :run, 'execute[install-keychain-script]', :immediately
end

execute 'make-keychain' do
  cwd git_app_workspace
  command 'make'
end

execute 'install-keychain-script' do
  cwd git_app_workspace
  command "cp keychain #{node['keychain']['install_root']}/keychain"
  not_if "test -e #{node['keychain']['install_root']}/keychain"
end
