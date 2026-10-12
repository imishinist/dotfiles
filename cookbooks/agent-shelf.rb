directory "#{ENV['HOME']}/.config"

link "#{ENV['HOME']}/.config/agent-shelf" do
  to File.expand_path('../config/.config/agent-shelf', __dir__)
end
