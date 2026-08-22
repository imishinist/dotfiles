module ::MItamae
  module Plugin
    module ResourceExecutor
      class GithubRelease < ::MItamae::ResourceExecutor::Base
        def apply
          case desired.action
          when :install
            run_install
          end
        end

        private

        def set_current_attributes(current, action)
          case action
          when :install
            current.exist = false
          else
            raise NotImplementedError, "unhandled action: '#{action}'"
          end
        end

        def set_desired_attributes(desired, action)
          case action
          when :install
            desired.exist = true
          end
        end

        def run_install
          url = metadata_url(desired.repository, desired.version)
          target_dir = desired.target_dir

          MItamae::logger.debug("url: #{url}, target_dir: #{target_dir}")
          content_type, download_url = get_content_type_and_download_url(url, desired.release_name)
          MItamae::logger.info("content_type: #{content_type}, download_url: #{download_url}")

          archive = "#{target_dir}.download"
          options = desired.tar_options
          command = case desired.release_name
                    when /\.tar\.gz\z/, /\.tgz\z/
                      "curl -fsSL #{download_url} | tar -C #{target_dir} #{options} -xz"
                    when /\.tar\.xz\z/
                      "curl -fsSL #{download_url} | tar -C #{target_dir} #{options} -xJ"
                    when /\.zip\z/
                      "curl -fsSL -o #{archive} #{download_url} && unzip -q #{archive} -d #{target_dir} && rm #{archive}"
                    when /\.gz\z/
                      if desired.is_tarball
                        raise NotImplementedError, "unsupported gzip archive: '#{desired.release_name}'"
                      end
                      "curl -fsSL #{download_url} | gzip -dc > #{target_dir}/#{desired.name}"
                    else
                      "curl -fsSL -o #{target_dir}/#{desired.name} #{download_url}"
                    end
          @runner.run_command("mkdir -p #{target_dir} && #{command}")
        end

        def get_content_type_and_download_url(url, release_name)
          output = @runner.run_command("curl -fsSL -H \"Accept: application/vnd.github+json\" #{url}")
          if output.exit_status != 0
            MItamae::logger.error(output.stderr)
            raise "Failed to download metadata from #{url}"
          end
          asset = JSON::parse(output.stdout)['assets'].filter{|a|
            a['name'] == release_name
          }.first

          unless asset
            raise "Release asset not found: #{release_name}"
          end

          [asset['content_type'], asset['browser_download_url']]
        end

        def metadata_url(repository, version)
          case version
          when "latest"
            "https://api.github.com/repos/#{repository}/releases/latest"
          else
            "https://api.github.com/repos/#{repository}/releases/tags/#{version}"
          end
        end
      end
    end
  end
end
