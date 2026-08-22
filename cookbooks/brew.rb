
execute "install homebrew" do
  command '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  not_if "type brew >/dev/null 2>&1"
end

return unless node[:platform] == 'darwin'

define :brew, cask: nil do
  cask = params[:cask] || false

  if cask
    execute "brew install --cask #{params[:name]}" do
      not_if "test -d \"$(brew --prefix)/Caskroom/#{params[:name]}\""
      subscribes :run, "execute[install homebrew]"
    end
  else
    package params[:name]
  end
end
