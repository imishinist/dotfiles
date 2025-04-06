HYPERFINE_VERSION = '1.19.0'.freeze

cli_binary 'hyperfine' do
  repository 'sharkdp/hyperfine'
  version "v#{HYPERFINE_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  release_name "hyperfine-v#{HYPERFINE_VERSION}-x86_64-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options '--strip-components 1'
end
