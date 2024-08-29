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

#@ARGV or die "Usage: splityaml2json {FILE|DIR}\n";
#my $x = splityaml_load($ARGV[0]);
##print Dumper($x);
#print YAML::Dump($x);
##print encode_json($x);
#
#exit 0;

1;
