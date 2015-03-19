#
# Cookbook Name:: keychain
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'git'
include_recipe 'keychain::deploy'
include_recipe 'minitest-handler'
