describe_recipe 'keychain_git_repo_deployment' do
  it 'should create keychain git repo' do
    keychain_workspace = File.join( Chef::Config[:file_cache_path], 'keychain' )
    directory( keychain_workspace ).must_exist.with( :owner, 'root' )
    assert_directory( keychain_workspace, 'root', 'root', '755' )
  end

  it 'make keychain script executable' do
    assert_sh( 'keychain -V', '2.7.2_beta1' )
  end

  it 'should copy keychain man page' do
    keychain_man_page_location = File.join( node['keychain']['manpath'], 'keychain.1.gz' )
    file( keychain_man_page_location ).must_exist.with( :owner, 'root' ).and( :user, 'root' )
    assert_file( keychain_man_page_location, 'root', 'root', '644' )
  end

  it 'should display keychain man page' do
    assert_sh( 'man -P cat keychain', '2.7.2_beta1' )
  end
end
