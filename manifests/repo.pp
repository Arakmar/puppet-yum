# Define: yum::repo
#
# This definition is a wrapper of the existing yumrepo define
# It adds a file resource to be able to purge the yum.repos.d dir
#
# Parameters:
#   [*yumrepo_attributes*]   - a list of attributes to be passed to yumrepo
#
# Actions:
#
# Requires:
#   RPM based system
#
# Sample usage:
#   yum::repo { 'myrepo':
#     yumrepo_attributes  => {
#       descr      => 'My Custom Repo',
#       mirrorlist => 'http://myrepo.org',
#       enabled    => 1,
#     },
#   }
#
define yum::repo (
    $yumrepo_attributes
){
    validate_hash($yumrepo_attributes)

    file { "/etc/yum.repos.d/${title}.repo":
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      require => Yumrepo[$title],
    }

    ensure_resource('yumrepo', $title, $yumrepo_attributes)
}
