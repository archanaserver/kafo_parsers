require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'

require 'manifest_file_factory'

BASIC_MANIFEST = <<EOS
# This manifests is used for testing
#
# It has no value except of covering use cases that we must test.
#
# === Parameters
#
# $version::         some version number
# $documented::      something that is documented but not used
# $undef::           default is undef
# $multiline::       param with multiline
#                    documentation
#                    consisting of 3 lines
# $typed::           something having it's type explicitly set
#                    type:boolean
# $multivalue::      list of users
#                    type:array
# === Advanced parameters
#
# $debug::           we have advanced parameter, yay!
#                    type:boolean
# $db_type::         can be mysql or sqlite
#
# ==== MySQL         condition: $db_type == 'mysql'
#
# $remote::          socket or remote connection
#                    type: boolean
# $server::          hostname
#                    condition: $remote
# $username::        username
# $password::        type:password
#                    condition:$username != 'root'
#
# ==== Sqlite        condition: $db_type == 'sqlite'
#
# $file::            filename
#
# === Extra parameters
#
# $log_level::       we can get up in levels
# $m_i_a::
#
class testing(
  $version = '1.0',
  $undocumented = 'does not have documentation',
  $undef = undef,
  $multiline = undef,
  $typed = true,
  $multivalue = ['x', 'y'],
  $debug = true,
  $db_type = 'mysql',
  $remote = true,
  $server = 'mysql.example.com',
  $username = 'root',
  $password = 'toor',
  $file = undef,
  $m_i_a = 'test') {

  validate_string($undocumented)
  if $version == '1.0' {
    # this must be ignored since we can't evaluate conditions
    validate_bool($undef)
  }

  package {"testing":
    ensure => present
  }
}
EOS

class Minitest::Spec
  before do

  end
end
