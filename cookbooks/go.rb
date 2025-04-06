
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
  not_if "test -d #{ENV['HOME']}/.goenv"
end

unless ENV['PATH'].include?("#{ENV['HOME']}/.goenv/bin:")
  MItamae.logger.info('Prepending ~/.goenv/bin to PATH during this execution')
  ENV['PATH'] = "#{ENV['HOME']}/.goenv/bin:#{ENV['PATH']}"
end

go_bin_path = "#{ENV['HOME']}/go/bin"
directory go_bin_path

define :goinstall, version: nil, bin_name: nil do
  name = params[:name]
  version = params[:version] || "latest"
  bin_name = params[:bin_name] || name.split("/").last

  execute "env GOBIN=#{go_bin_path} go install #{name}@#{version}" do
    not_if "test -e #{go_bin_path}/#{bin_name}"
  end
end

# formatter
goinstall "golang.org/x/tools/cmd/goimports" do
  bin_name "goimports"
end

# lint
goinstall "honnef.co/go/tools/cmd/staticcheck" do
  bin_name "staticcheck"
end

# debugger
goinstall "github.com/go-delve/delve/cmd/dlv" do
  bin_name "dlv"
end

# lsp-server
goinstall "golang.org/x/tools/gopls" do
  bin_name "gopls"
end

# protobuf config
goinstall "google.golang.org/protobuf/cmd/protoc-gen-go" do
  bin_name "protoc-gen-go"
end

