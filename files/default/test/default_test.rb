describe_recipe 'keychain_git_repo_deployment' do
  it 'should create git repo' do
    keychain_workspace = File.join( Chef::Config[:file_cache_path], 'keychain' )
    directory( keychain_workspace ).must_exist.with( :owner, 'root' )
    assert_directory( keychain_workspace, 'root', 'root', '755' )
  end
end
