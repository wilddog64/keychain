describe_recipe 'keychain_git_repo_deployment' do
  it 'should create git repo' do
    keychain_workspace = File.join( Chef::Config[:file_cache_path], 'keychain' )
    directory( keychain_workspace ).must_exist.with( :owner, 'root' )
    assert_directory( keychain_workspace, 'root', 'root', '755' )
  end

  it 'make keychain script executable' do
    assert_sh( 'keychain -V', '2.7.2_beta1' )
  end
end
