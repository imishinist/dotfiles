
execute "install homebrew" do
  command "ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
  not_if "type brew >/dev/null 2>&1"
end

define :brew, opt: nil do
  opt = params[:opt] || ""

  execute "brew install #{opt} #{params[:name]}" do
    not_if "brew list #{opt} | grep \"^#{params[:name]}$\""
  end
end