
execute "install goenv" do
  command "git clone https://github.com/syndbg/goenv.git #{ENV['HOME']}/.goenv"
  not_if "test -d #{ENV['HOME']}/.goenv"
end

gopath = "#{ENV['HOME']}/workspace/golang"
define :goinstall, version: nil, bin_name: nil do
  name = params[:name]
  v = params[:version] || "latest"
  b = params[:bin_name] || name.split("/").last

  execute "env GOPATH=#{gopath} go install #{name}@#{v}" do
    not_if "test -e #{gopath}/bin/#{b}"
  end
end

# TODO: goがまだ入ってないときに失敗する
# goenv入れただけでは最新版のgoは入らないので
