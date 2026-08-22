UV_VERSION = '0.12.5'.freeze

execute 'install uv' do
  command "curl -LsSf https://astral.sh/uv/#{UV_VERSION}/install.sh | env UV_NO_MODIFY_PATH=1 sh"
  not_if "test -x #{ENV['HOME']}/.local/bin/uv"
end
