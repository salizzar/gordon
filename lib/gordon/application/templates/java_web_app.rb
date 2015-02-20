path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib'))
$LOAD_PATH.unshift path

require 'gordon'

$env_vars = Gordon::EnvVars.load

class JavaWebApp < FPM::Cookery::Recipe
  extend  Gordon::Cookery::DependencyResolver

  include Gordon::Cookery::Common,
          Gordon::Cookery::WebServer,
          Gordon::Cookery::Java::Common,
          Gordon::Cookery::Java::WebApp

  name        $env_vars.app_name
  description $env_vars.app_desc
  version     $env_vars.app_version
  homepage    $env_vars.app_repo
  arch        :noarch

  source      $env_vars.app_source_dir, with: :local_path

  depends     *resolve_dependencies($env_vars)

  fpm_attributes[:rpm_user]   = 'tomcat'
  fpm_attributes[:rpm_group]  = 'tomcat'

  def build
    war_path = File.join(get_skeleton_path_from_type($env_vars.web_server_type), $env_vars.app_name)

    clean_java_web_workdir($env_vars, war_path)
  end

  def install
    install_web_server_files($env_vars, JAVA_BLACKLIST_FILES)
  end
end

