exec { "apt-get-update":
	command => "apt-get update",
	path => "/usr/bin",
}

package { "git-core":
	ensure  => present,
	require => Exec["apt-get-update"],
}

package { "puppet":
	ensure  => present,
	require => Exec["apt-get-update"],
}

file { "purge-puppet-dir":
	path => "/etc/puppet",
	ensure => directory,
	purge => true,
	require => Package["puppet"],
	force => true,
	recurse => true,
}

exec { "clone-masterless-puppet":
	command => "/usr/bin/git clone https://github.com/crehders/masterless-puppet /etc/puppet/",
	require => [
		File["purge-puppet-dir"],
		Package["git-core"],
	],
	user => root,
}

exec { "puppet-apply":
	command => "/usr/bin/puppet apply /etc/puppet/manifests/site.pp",
	require => Exec[clone-masterless-puppet],
	user => root,
}
