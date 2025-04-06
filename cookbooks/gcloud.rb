
gcloud_install = "/tmp/gcloud_install.sh"
execute 'download install.sh' do
  command "curl https://sdk.cloud.google.com > #{gcloud_install}"
  not_if "test -f #{gcloud_install}"
end

bin_dir = "#{ENV['HOME']}/bin"
directory bin_dir do
  not_if "test -d #{bin_dir}"
end

install_dir = "#{ENV['HOME']}/.opt"
directory install_dir do
  not_if "test -d #{install_dir}"
end

execute 'download gcloud' do
  command "bash #{gcloud_install} --disable-prompts --install-dir=#{install_dir}"
  not_if "test -d #{install_dir}/google-cloud-sdk"
end

link "#{bin_dir}/gcloud" do
  to "#{install_dir}/google-cloud-sdk/bin/gcloud"
  not_if "test -L #{bin_dir}/gcloud"
end
