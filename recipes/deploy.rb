# keychain::deploy script will deploy keychain script
file_cache_path = Chef::Config[:file_cache_path]
git_app_workspace = File.join( file_cache_path, 'keychain' )
git git_app_workspace do
  repository node['keychain']['git']['repo']
  action :sync
  notifies :run, 'execute[git-keychain-cleanup]', :immediately
  notifies :run, 'execute[make-keychain]', :immediately
  notifies :run, 'execute[install-keychain-script]', :immediately
  notifies :run, 'execute[make-keychain-gz]'
  notifies :run, 'execute[copy-keychain-man-page]'
end

execute 'git-keychain-cleanup' do
  cwd git_app_workspace
  command 'git clean -d -f'
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

execute 'make-keychain-gz' do
  cwd git_app_workspace
  command 'make keychain.1.gz'
  only_if '[ ! -e keychain.1.gz ]'
end

execute 'copy-keychain-man-page' do
  cwd git_app_workspace
  command <<-EOF
  cp keychain.1.gz #{node['keychain']['manpath']}/keychain.1.gz
  EOF
  not_if "test -e #{node['keychain']['manpath']}/keychain.1.gz"
end
