
case node[:os]
when 'darwin'
  package "go"
when 'linux'
  snap 'go' do
    classic true
  end
end

execute "install goenv" do
  command "git clone https://github.com/syndbg/goenv.git #{ENV['HOME']}/.goenv"
  user node[:user]
  not_if "test -d #{ENV['HOME']}/.goenv"
end

unless ENV['PATH'].include?("#{ENV['HOME']}/.goenv/bin:")
  MItamae.logger.info('Prepending ~/.goenv/bin to PATH during this execution')
  ENV['PATH'] = "#{ENV['HOME']}/.goenv/bin:#{ENV['PATH']}"
end

gopath = "#{ENV['HOME']}/workspace/golang"
directory gopath do
  user node[:user]
end

define :goinstall, version: nil, bin_name: nil do
  name = params[:name]
  v = params[:version] || "latest"
  b = params[:bin_name] || name.split("/").last

  execute "env GOPATH=#{gopath} go install #{name}@#{v}" do
    user node[:user]
    not_if "test -e #{gopath}/bin/#{b}"
  end
end

