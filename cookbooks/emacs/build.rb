
case node[:os]
when "darwin"
  package "texinfo"
  package "libgccjit"
when "linux"
  raise NotImplementedError
end

# remove emacs-build directory if you want to update version
EMACS_VERSION = "emacs-30.1".freeze
emacs_dir = "#{ENV['HOME']}/.local/share/emacs-build"
execute "clone emacs" do
  command "git clone https://github.com/emacs-mirror/emacs.git --depth 1 -b #{EMACS_VERSION} #{emacs_dir}"
  not_if "test -d #{emacs_dir}"
end

execute "./autogen.sh" do
  cwd emacs_dir
  not_if "test -f #{emacs_dir}/configure"
end

opts = %w[tree-sitter xwidgets native-compilation=aot imagemagick].map{|i| "--with-#{i}" }.join(" ")
execute "configure" do
  command "./configure --prefix=#{ENV['HOME']}/.local #{opts}"
  cwd emacs_dir
  not_if "test -f #{emacs_dir}/Makefile"
end

execute "make" do
  command "make -j$(nproc)"
  cwd emacs_dir
  not_if "test -f #{emacs_dir}/src/emacs"
end

case node[:os]
when "darwin"
  execute "make install" do
    cwd emacs_dir
    not_if "test -f #{emacs_dir}/nextstep/Emacs.app/Contents/MacOS/bin/emacsclient"
  end
when "linux"
  raise NotImplementedError
end
