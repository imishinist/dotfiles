MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path('../..', __FILE__)
    cookbook_path = File.join(root_dir, 'cookbooks')
    if File.directory?(File.join(cookbook_path, name))
      include_recipe File.join(cookbook_path, name, 'default')
      return
    end
    include_recipe File.join(cookbook_path, name)
  end

  def include_role(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'roles', name, 'default')
  end

  def has_package?(name)
    result = run_command("dpkg-query -f '${Status}' -W ${name.shellescape} | grep -E '^(install|hold) ok installed$'", error: false)
    result.exit_status == 0
  end
end

define :touch do
  target = params[:name]
  path = File.join(ENV['HOME'], target)
  execute "touch" do
    command "touch #{path}"
  end
end

define :dotfile, source: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../config/#{source}", __FILE__)
    force true
  end
end

define :dotfile_copy, source: nil do
  source = params[:source] || params[:name]
  remote_file params[:name] do
    path File.join(ENV['HOME'], params[:name])
    source File.expand_path("../../config/#{source}", __FILE__)
  end
end

define :cli_binary, repository: nil, version: nil, release_name: nil, target_dir: nil, tar_options: nil, bin_path: nil, is_tarball: nil do
  cmd = params[:name]
  real_dir = File.join(params[:target_dir], "#{cmd}-#{params[:version]}")
  real_cmd_path = File.join(real_dir, cmd)
  real_cmd_path = File.join(real_dir, params[:bin_path]) if params[:bin_path]
  target_cmd_path = File.join(params[:target_dir], cmd)
  is_tarball = params[:is_tarball].nil? ? true : false

  github_release cmd do
    repository params[:repository]
    version params[:version]
    release_name params[:release_name]
    target_dir real_dir
    tar_options params[:tar_options]
    is_tarball is_tarball

    not_if "readlink #{target_cmd_path} | grep #{real_dir} && test -f #{real_cmd_path}"
  end

  link target_cmd_path do
    to real_cmd_path
    force true

    action :nothing
    subscribes :create, "github_release[#{cmd}]"
  end

  execute "chmod +x #{real_cmd_path}" do
    action :nothing
    subscribes :run, "github_release[#{cmd}]"
  end
end

define :snap, classic: nil do
  opt = ""
  opt = "--classic" if params[:classic]
  execute "snap install #{params[:name]} #{opt}" do
    not_if "snap list | grep \"#{params[:name]}\""
  end
end

define :apt_add_repository do
  raise NotImplementedError unless params[:name].include?("ppa")

  repo = params[:name].split(":")[1]

  execute "apt-add-repository -y #{params[:name]}" do
    not_if "apt-add-repository --list | grep \"#{repo}\""
  end
end
