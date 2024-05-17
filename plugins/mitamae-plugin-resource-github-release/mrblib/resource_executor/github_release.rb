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

          case content_type
          when "application/gzip", "application/zip", "application/x-gtar"
            if desired.is_tarball
              options = desired.tar_options
              @runner.run_command("mkdir -p #{target_dir} && curl -sL -o- #{download_url} | tar -C #{target_dir} #{options} -xz")
            else
              @runner.run_command("mkdir -p #{target_dir} && curl -sL -o- #{download_url} | gunzip -c > #{target_dir}/#{desired.name}")
            end
          when "application/x-xz"
            options = desired.tar_options
            @runner.run_command("mkdir -p #{target_dir} && curl -sL -o- #{download_url} | tar -C #{target_dir} #{options} -xJ")
          when "application/octet-stream"
            if download_url.end_with?(".tar.gz")
              options = desired.tar_options
              @runner.run_command("mkdir -p #{target_dir} && curl -sL -o- #{download_url} | tar -C #{target_dir} #{options} -xz")
            else
              @runner.run_command("mkdir -p #{target_dir} && curl -sL -o #{target_dir}/#{desired.name} #{download_url}")
            end
          else
            raise NotImplementedError, "unsupported content_type: '#{content_type}'"
          end
        end

        def get_content_type_and_download_url(url, release_name)
          output = @runner.run_command("curl -sL -H \"Accept: application/vnd.github+json\" #{url}")
          if output.exit_status != 0
            MItamae::logger.error(output.stderr)
            raise "Failed to download metadata from #{url}"
          end
          asset = JSON::parse(output.stdout)['assets'].filter{|a|
            a['name'] == release_name
          }.first

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
