name 'rails-server'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures rails-server'
long_description 'Installs/Configures rails-server'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/rails-server/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/rails-server'
depends 'nodejs', '~> 3.0.0'
depends 'build-essential', '~> 8.0.1'
depends 'system', '~> 0.11.2'
depends 'git', '~> 6.0.0'
depends 'ruby_build', '~> 1.1.0'
depends 'ruby_rbenv', '~> 1.2.0'
# depends 'postgresql', '= 6.0.1'
# depends 'database', '~> 6.1.1'
