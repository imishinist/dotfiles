
%w[.config .config/emacs].each do |dir|
  directory "#{ENV['HOME']}/#{dir}"
end

dotfile '.config/emacs/init.el'
