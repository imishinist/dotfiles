
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

goinstall 'golang.org/x/tools/cmd/goimports'
goinstall 'github.com/go-delve/delve/cmd/dlv'
goinstall 'github.com/golang/protobuf/protoc-gen-go'
goinstall 'github.com/tsenart/vegeta'
goinstall 'github.com/orisano/dlayer'
goinstall 'github.com/orisano/bctx'
goinstall 'github.com/spf13/cobra'