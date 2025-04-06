
%w[.config .config/emacs].each do |dir|
  directory "#{ENV['HOME']}/#{dir}"
end


case node[:os]
when "darwin"
  package "emacs"
when "linux"
  case node[:platform]
  when "arch"
    package 'emacs'
  when "ubuntu"
    snap "emacs" do
      classic true
    end
  end
end

dotfile '.config/emacs/init.el'
