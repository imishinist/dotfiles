unless ENV['PATH'].include?("#{ENV['HOME']}/.cargo/bin:")
  MItamae.logger.info('Prepending ~/.cargo/bin to PATH during this execution')
  ENV['PATH'] = "#{ENV['HOME']}/.cargo/bin:#{ENV['PATH']}"
end

local_ruby_block 'install rust' do
  rustc_path = "#{ENV['HOME']}/.cargo/bin/rustc"

  block do
    case node[:os]
    when "darwin", "linux"
      system("bash -c 'curl https://sh.rustup.rs -sSf | sh'")
    # when "linux"
      # system("sudo -u #{node[:user]} bash -c 'curl https://sh.rustup.rs -sSf | sh'")
    else
      raise NotImplementedError
    end

    until File.exist?(rustc_path)
      sleep 1
    end
  end
  not_if "test -f #{rustc_path}"
end
