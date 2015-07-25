# Red Hat Vagrant Tech Talk Base Puppet Manifest

$project_name = "tech-talk"

    include packageUpdate
    include baseInstall
    include gnomeInstall
    include afterInstall
    include ssh

class packageUpdate 
{
   exec
   {
      "dnf update packages":
      path => ["/usr/bin/","/usr/sbin/","/bin"],
      command => "dnf -y upgrade",
      timeout => 1800,
      user => root
   }
}

class baseInstall
{
	$packages = ['kernel-debug', 'gcc']
	package{
		$packages:
		ensure => latest
	}

	#Example file sync
	file {
   		'/home/vagrant/.bashrc':
      		owner => 'vagrant',
      		group => 'vagrant',
      		mode  => '0644',
      		source => '/vagrant/puppet/files/.bashrc';
  	}
}

class gnomeInstall
{
   exec { "GUI Group Install":
      path => ["/usr/bin/","/usr/sbin/","/bin"],
      command => 'dnf -y group install "Fedora Workstation"',
      timeout => 1800,
      user => root
   }
   package 
   {   "gdm":
       ensure => latest
   }
}

class afterInstall
{
   exec { "enable gui":
      path => ["/usr/bin/","/usr/sbin/","/bin"],
      command => 'systemctl set-default graphical.target',
      timeout => 1800,
      user => root
  }
}

class ssh
{
   service { "sshd":        
      ensure => "running",
      enable => "true"
   }
	file {
   		'/etc/gdm/custom.conf':
      		owner => 'root',
      		group => 'root',
      		mode  => '0644',
      		source => '/vagrant/puppet/files/custom.conf';
  	}
}
