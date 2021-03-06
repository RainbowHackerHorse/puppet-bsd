define bsd::network::interface::cloned (
  $ensure,
) {

  case $facts['kernel'] {
    'FreeBSD': {
      case $ensure {
        'present','up': {
          $cloned_ensure = 'present'
        }
        'absent','down': {
          $cloned_ensure = 'absent'
        }
        default: {
          fail('Incorrect state ensure set for shellvar')
        }
      }

      shellvar { "cloned_interfaces_${name}":
        ensure       => $cloned_ensure,
        variable     => 'cloned_interfaces',
        target       => '/etc/rc.conf',
        value        => $name,
        array_append => true,
        notify       => Bsd_interface[$name],
      }
    }
    default: {
      notice("No cloned interface handling implemented on ${facts['kernel']}")

    }
  }

}
