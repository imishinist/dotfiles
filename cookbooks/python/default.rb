unless ENV['PATH'].include?("#{ENV['HOME']}/.rye/shims:")
  MItamae.logger.info('Prepending ~/.rye/shims to PATH during this execution')
  ENV['PATH'] = "#{ENV['HOME']}/.rye/shims:#{ENV['PATH']}"
end

local_ruby_block 'install python' do
  rye_path = "#{ENV['HOME']}/.rye/shims/rye"

  block do
    case node[:os]
    when "darwin", "linux"
      system("bash -c 'curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION=\"--yes\" bash'")
    else
      raise NotImplementedError
    end

    until File.exist?(rye_path)
      sleep 1
    end
  end
  not_if "test -f #{rye_path}"
end
