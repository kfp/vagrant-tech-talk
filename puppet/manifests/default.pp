# Red Hat Vagrant Tech Talk Base Puppet Manifest

$project_name = "tech-talk"

    include packageUpdate
    include gnomeInstall

class packageUpdate 
{
   exec
   {
      "dnf update packages":
      command => "/bin/dnf -y upgrade",
      timeout => 1800
   }
}

class gnomeInstall
{
   exec { "Gnome3 Group Install":
      command => '/bin/dnf -y group install "GNOME Desktop Environment"',
      timeout => 1800
   }
   package 
   {   "gdm":
       ensure => latest
   }
}
