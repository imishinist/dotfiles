
execute "install homebrew" do
  command "ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
  not_if "type brew >/dev/null 2>&1"
end

return unless node[:platform] == 'darwin'

define :brew, cask: nil do
  cask = params[:cask] || false

  if cask
    execute "brew install --cask #{params[:name]}" do
      not_if "ls -1 $(brew --prefix)/Caskroom/ | cut -d\"/\" -f1 | grep -E \"^#{params[:name]}$\""
      subscribes :run, "execute[install homebrew]"
    end
  else
    package params[:name]
  end
end