$app_name       = ENV['GORDON_APP_NAME']
$app_desc       = ENV['GORDON_APP_DESC']
$app_repo       = ENV['GORDON_APP_REPO']
$app_version    = ENV['GORDON_APP_VERSION']
#app_depends    = ENV['GORDON_APP_DEPENDS']
$app_source_dir = ENV['GORDON_APP_SOURCE_DIR']

$skeleton_type  = ENV['GORDON_SKELETON_TYPE']
$skeleton_files = ENV['GORDON_SKELETON_FILES']

$init_type      = ENV['GORDON_INIT_TYPE']
$init_build_dir = ENV['GORDON_INIT_BUILD_DIR']

path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'lib'))
$LOAD_PATH.unshift path

require 'gordon'

class RubyWebApp < FPM::Cookery::Recipe
  include Gordon::Cookery::Common,
          Gordon::Cookery::Init,
          Gordon::Cookery::Webserver

  name        $app_name
  description $app_desc
  version     $app_version
  homepage    $app_repo

  source      $app_source_dir, with: :local_path
# depends     $app_depends

  def build
    vendor_gems
  end

  def install
    setup_init_files
    setup_webserver_files
  end
end

