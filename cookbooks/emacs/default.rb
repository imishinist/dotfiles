
%w[.config .config/emacs].each do |dir|
  directory "#{ENV['HOME']}/#{dir}"
end


case node[:os]
when "darwin"
  package "emacs"
when "linux"
  snap "emacs" do
    classic true
  end
end

dotfile '.config/emacs/init.el'
