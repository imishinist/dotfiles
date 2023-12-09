
module ::MItamae
  module Plugin
    module Resource
      class GithubRelease < ::MItamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :name, type: String, default_name: true
        define_attribute :repository, type: String, required: true
        define_attribute :version, type: String
        define_attribute :release_name, type: String, required: true
        define_attribute :target_dir, type: String, required: true
        define_attribute :tar_options, type: String, default: ""

        self.available_actions = [:install]
      end
    end
  end
end
