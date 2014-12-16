path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib'))
$LOAD_PATH.unshift path

require 'gordon'

$env_vars = Gordon::EnvVars.load

class RubyWebApp < FPM::Cookery::Recipe
  include Gordon::Cookery::Common,
          Gordon::Cookery::Init,
          Gordon::Cookery::ApplicationUser,
          Gordon::Cookery::HttpServer,
          Gordon::Cookery::Ruby::Common

  name        $env_vars.app_name
  description $env_vars.app_desc
  version     $env_vars.app_version
  homepage    $env_vars.app_repo

  source      $env_vars.app_source_dir, with: :local_path

  def build
    home_path = get_skeleton_path_from_type($env_vars.http_server_type)

    create_user_and_group(home_path)
    setup_user_permissions(home_path)

    create_init

    ruby_vendor_gems
  end

  def install
    install_init
    install_http_server_files(RUBY_BLACKLIST_FILES)
  end
end

