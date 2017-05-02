# default['nodejs']['install_method'] = "binary"
default['nodejs']['version'] = '6.10.0'
default['nodejs']['binary']['checksum'] = '99c4136cf61761fac5ac57f80544140a3793b63e00a65d4a0e528c9db328bf40'

default['build-essential']['compile_time'] = false
default['build-essential']['msys2']['path'] = "#{ENV['SYSTEMDRIVE']}\\msys2"



node.default['rbenv']['user_installs'] = [
  { 'user'    => 'ubuntu',
    'rubies'  => ['2.4.0'],
    'global'  => '2.4.0',
    'gems'    => {
      '2.4.0'    => [
        # { 'name'    => 'bundler',
        #   'version' => '1.1.rc.5'
        # },
        # { 'name'    => 'rake' }
      ]
    }
  }
]

default['system']['packages']['install'] = ['redis-server', 'nodejs', 'libpq-dev']

# node['system'['packages'] {
#        packages: {
#          install: ["redis-server", "nodejs", "libpq-dev"]
#        }


# git repository containing the ruby-build framework
default['ruby_build']['git_url'] = 'https://github.com/rbenv/ruby-build.git'
default['ruby_build']['git_ref'] = 'master'

# default base path for a system-wide installed Ruby
default['ruby_build']['default_ruby_base_path'] = '/usr/local/ruby'

# ruby-build upgrade action
default['ruby_build']['upgrade'] = 'none'

case node['platform_family']
when 'rhel', 'fedora'
  default['ruby_build']['install_pkgs'] = %w( tar bash curl )
  default['ruby_build']['install_pkgs_cruby'] =
    %w( gcc-c++ patch readline-devel zlib-devel
        libffi-devel openssl-devel libyaml-devel
        make bzip2 autoconf automake libtool bison
        libxml2 libxml2-devel libxslt libxslt-devel
        gdbm-devel )
  default['ruby_build']['install_pkgs_rbx'] =
    %w( ncurses-devel llvm-static llvm-devel ) + node['ruby_build']['install_pkgs_cruby']
  default['ruby_build']['install_pkgs_jruby'] = []

when 'debian'
  default['ruby_build']['install_pkgs'] = %w( tar bash curl )
  default['ruby_build']['install_pkgs_cruby'] =
    %w( autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev
        zlib1g-dev libsqlite3-dev libxml2-dev libxslt1-dev
        libc6-dev libffi-dev libgdbm3 libgdbm-dev )
  default['ruby_build']['install_pkgs_rbx'] =
    %w( libncurses5-dev llvm-3.4 llvm-3.4-dev libeditline-dev libedit-dev
      ) + node['ruby_build']['install_pkgs_cruby']

  default['ruby_build']['install_pkgs_jruby'] = %w( make g++ )

when 'suse'
  default['ruby_build']['install_pkgs'] = %w( tar bash curl )
  default['ruby_build']['install_pkgs_cruby'] =
    %w( gcc-c++ automake patch zlib-devel libffi48-devel libyaml-devel
        sqlite3-devel libxml2-devel libxslt-devel autoconf gdbm-devel
        libopenssl-devel readline-devel libyaml-devel )
  default['ruby_build']['install_pkgs_rbx'] =
    %w( ncurses-devel ) + node['ruby_build']['install_pkgs_cruby']
  default['ruby_build']['install_pkgs_jruby'] = []

when 'mac_os_x'
  default['ruby_build']['install_pkgs'] = []
  default['ruby_build']['install_pkgs_cruby'] = %w( openssl libyaml libffi )
  default['ruby_build']['install_pkgs_jruby'] = []

when 'freebsd'
  default['ruby_build']['install_pkgs'] = []
  default['ruby_build']['install_pkgs_cruby'] =
    %w( autoconf autoconf-wrapper automake automake-wrapper indexinfo
        libedit libffi libyaml m4 perl5 gmake )
  default['ruby_build']['install_pkgs_jruby'] =
    %w( alsa-lib bash dejavu expat fixesproto fontconfig freetype2
        gettext-runtime giflib indexinfo inputproto java-zoneinfo
        javavmwrapper kbproto libICE libSM libX11 libXau libXdmcp libXext
        libXfixes libXi libXrender libXt libXtst libfontenc libpthread-stubs
        libxcb libxml2 mkfontdir mkfontscale openjdk8 recordproto renderproto
        xextproto xproto )
end

case node['platform']
when 'debian','ubuntu','redhat','centos','amazon','scientific','fedora','freebsd','suse'
  default['user']['home_root']      = "/home"
  default['user']['default_shell']  = "/bin/bash"
when 'openbsd'
  default['user']['home_root']      = "/home"
  default['user']['default_shell']  = "/bin/ksh"
when 'mac_os_x', 'mac_os_x_server'
  default['user']['home_root']      = "/Users"
  default['user']['default_shell']  = "/bin/bash"
when 'omnios'
  default['user']['home_root']      = "/export/home"
  default['user']['default_shell']  = "/bin/bash"
else
  default['user']['home_root']      = "/home"
  default['user']['default_shell']  = nil
end
