node.reverse_merge!(
  os: run_command('uname').stdout.strip.downcase,
)

define :dotfile, source: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../../config/#{source}", __FILE__)
    user node[:user]
    force true
  end
end

package 'unzip'

define :github_binary, version: nil, repository: nil, archive: nil, binary_path: nil do
  cmd = params[:name]
  bin_path = "#{ENV['HOME']}/bin/#{cmd}"
  archive = params[:archive]
  url = "https://github.com/#{params[:repository]}/releases/download/#{params[:version]}/#{archive}"

  if archive.end_with?('.zip')
    extract = "unzip -o"
  elsif archive.end_with?(".tar.gz")
    extract = "tar xvzf"
  else
    extract = "touch"
  end

  execute "curl -fSL -o /tmp/#{archive} #{url}" do
    not_if "test -f #{bin_path}"
  end

  execute "#{extract} /tmp/#{archive}" do
    not_if "test -f #{bin_path}"
    cwd "/tmp"
  end

  execute "mv /tmp/#{params[:binary_path] || cmd} #{bin_path} && chmod +x #{bin_path}" do
    not_if "test -f #{bin_path}"
  end
end

define :snap, classic: nil do
  opt = ""
  opt = "--classic" if params[:classic]
  execute "snap install #{params[:name]} #{opt}" do
    not_if "snap list | grep \"^#{params[:name]}$\""
  end
end

define :apt_add_repository do
  raise NotImplementedError unless params[:name].include?("ppa")

  repo = params[:name].split(":")[1]

  execute "apt-add-repository #{params[:name]}" do
    not_if "apt-add-repository --list | grep \"#{repo}\""
  end
end
