path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib'))
$LOAD_PATH.unshift path

require 'gordon'

$env_vars = Gordon::EnvVars.load

class RubyWebApp < FPM::Cookery::Recipe
  extend  Gordon::Cookery::DependencyResolver

  include Gordon::Cookery::Common,
          Gordon::Cookery::Init,
          Gordon::Cookery::ApplicationUser,
          Gordon::Cookery::HttpServer,
          Gordon::Cookery::Ruby::Common

  name        $env_vars.app_name
  description $env_vars.app_description
  version     $env_vars.app_version
  homepage    $env_vars.app_homepage

  source      $env_vars.app_source, with: :local_path

  depends     *resolve_dependencies($env_vars, platform)

  def build
    home_path = get_skeleton_path_from_type($env_vars, $env_vars.http_server_type)

    create_user_and_group($env_vars, home_path)
    setup_user_permissions($env_vars, home_path)

    create_init($env_vars, $env_vars.http_server_type)
  end

  def install
    install_init($env_vars)
    install_http_server_files($env_vars, RUBY_BLACKLIST_FILES)
  end
end

