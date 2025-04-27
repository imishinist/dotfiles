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
