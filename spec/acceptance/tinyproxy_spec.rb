require 'spec_helper_acceptance'

describe 'tinyproxy class' do
  let(:manifest) do
    <<-EOS
      include ::tinyproxy
    EOS
  end

  it 'should work without errors' do
    expect(apply_manifest(manifest, catch_failures: true).exit_code).to eq 2
  end

  it 'should run a second time without changes' do
    expect(apply_manifest(manifest).exit_code).to be_zero
  end

  describe yumrepo('epel'), if: os[:family] == 'redhat' do
    it { should be_enabled }
  end

  describe package('tinyproxy') do
    it { should be_installed }
  end

  config_path = case os[:family]
                when 'redhat' then '/etc/tinyproxy/tinyproxy.conf'
                when 'debian' then '/etc/tinyproxy.conf'
                when 'ubuntu' then '/etc/tinyproxy.conf'
                end

  describe file(config_path) do
    it { should be_file }
  end

  describe service('tinyproxy') do
    it { should be_enabled }
    it { should be_running }
  end

  proc_user = case os[:family]
         when 'redhat' then 'tinyproxy'
         when 'debian' then 'nobody'
         when 'ubuntu' then 'nobody'
         end

  describe process('tinyproxy') do
    it { should be_running }
    its(:user) { should eq proc_user }
  end

  describe port(8888) do
    it { should be_listening.with('tcp') }
  end
end
