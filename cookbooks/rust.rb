unless ENV['PATH'].split(':').include?("#{ENV['HOME']}/.cargo/bin")
  MItamae.logger.info('Prepending ~/.cargo/bin to PATH during this execution')
  ENV['PATH'] = "#{ENV['HOME']}/.cargo/bin:#{ENV['PATH']}"
end

execute 'install rustup' do
  command 'curl -fsSf https://sh.rustup.rs | sh -s -- -y --no-modify-path'
  not_if "test -x #{ENV['HOME']}/.cargo/bin/rustc"
end
