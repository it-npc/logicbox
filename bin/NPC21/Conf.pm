package NPC21::Conf;

# "Split YAML" loading from a file tree:
#
# conf/conf.yml/
# conf/conf.yml/bc3
# conf/conf.yml/bc3/conf.yml
# conf/conf.yml/bc3/slot-1
# conf/conf.yml/bc3/slot-1/conf.yml
# conf/conf.yml/bc3/slot1
# conf/conf.yml/bc3/slot1/conf.yml
# conf/conf.yml/bc2
# conf/conf.yml/bc2/slot-1
# conf/conf.yml/bc2/slot-1/conf.yml
# conf/conf.yml/bc2/slot1
# ...

use YAML;
use JSON;
use Data::Dumper;

sub load {
    my ($file) = @_;
    if (-f $file) {
        my $ret = eval {YAML::LoadFile($file)};
        if ($@) {
            my ($err) = ($@ =~ /YAML Error: (.*)/);
            my ($line) = ($@ =~ /Line: (\d+)/);
            $line -= 3;         # investigate later
            die "$file:$line: $err\n";
        }
        return $ret;
    }
    elsif (-d $file) {
        my $ret = {};
        if (-f "$file/conf.yml") {
            $ret = load("$file/conf.yml");
        }
        opendir (my $dh, $file) or die "$file: $!\n";
        local $_;
        while (readdir $dh) {
            if (/^\w+(-\d+)?$/) { # identifier or identifier-N
                if (exists $ret->{$_}) {
                    warn "$file/$_: also seen in $file/conf.yml\n";
                }
                my $z = load("$file/$_");
                $ret->{$_} = $z;
            }
        }
        return $ret;
    }
    else {
        die "$file: $!\n";
    }
}

# return mac address of the "main" base module for $plc_name from
# conf.yml tree.  For LB241, it is the slot-1 module.  For LB340, it
# is the base module with the lowest slot number.
sub macaddr {
    my ($tree, $plc_name) = @_;
    my @candidates;
    for (keys %{$tree->{$plc_name}}) {
        ref $tree->{$plc_name}{$_} || next; # shallow, e.g. `hostname'
        my $macaddr = $tree->{$plc_name}{$_}{macaddr} // next;
        my $module = $tree->{$plc_name}{$_}{module} // next;
        if ($module =~ /^bcbase|LB241BC|LB241CPU/) {
            if (/^slot-1$/) {
                return $macaddr;    # LB241, no need to look further
            }
        }
        elsif ($module =~ /LB340CPU/) {
            /^slot(\d+)/ || die "`$_': expected slotN";
            push @candidates, [$1, $macaddr];
        }
        else {
            # i/o module with macaddr, not base
        }
    }

    for (sort {$a->[0]<=>$b->[0]} @candidates) {
        if ($_->[0] >= 1) {  # negative invalid for LB340
            return $_->[1];
        }
    }
    die "$conffile: $plc_name: no base module with macaddr specified\n"; 
}


#@ARGV or die "Usage: splityaml2json {FILE|DIR}\n";
#my $x = splityaml_load($ARGV[0]);
##print Dumper($x);
#print YAML::Dump($x);
##print encode_json($x);
#
#exit 0;

1;
