#!/usr/bin/perl

sub usage {
    die "Usage: mk-linker-script TEXT_START DATA_START BSS_START\n";
}

@ARGV == 3 or usage();
my ($text_start, $data_start, $bss_start) = @ARGV;

## Read the map, put data in %map
## Only take symbols from ESP ROM which won't change on firmware upgrade
##  0x0000000040002574                __umoddi3 = 0x40002574
##  0x0000000040002580                __umodsi3 = 0x40002580
##  0x000000004000258c                __unorddf2 = 0x4000258c
##  0x0000000040002598                __unordsf2 = 0x40002598
##  0x00000000400011dc                esp_rom_newlib_init_common_mutexes = 0x400011dc
##  0x00000000400011e8                memset = 0x400011e8
##  0x00000000400011f4                memcpy = 0x400011f4
##  0x0000000040001200                memmove = 0x40001200
#my %map;
#my $file = "../net/build/net.map";
#open(my $fh, $file) or die "$file: $!\n";
#while(<$fh>) {
#    if (/0x00000000400\w+\s+(\w+) = (0x400\w+)/) {
#        $map{$1} = $2;
#    }
#    # format changed starting from esp-idf-v5.2.1
#    if (/0x400\w{5}\s+(\w+) = (0x400\w+)/) {
#        $map{$1} = $2;
#    }
#}

while(<DATA>) {
    s,%TEXT_START%,$text_start,;
    s,%DATA_START%,$data_start,;
    s,%BSS_START%,$bss_start,;
#    if (/^%%/) {
#        for my $name (sort keys %map) {
#            print "$name = $map{$name};\n"
#        }
#        next;  # don't print the %% line
#    }
    print;
}

exit 0;

__DATA__
/*
 * https://allthingsembedded.com/post/2020-04-11-mastering-the-gnu-linker-script/
 */
/* selected ROM addresses of esp32s3 */
/*%%*/
__absvdi2 = 0x4000216c;
__absvsi2 = 0x40002178;
__adddf3 = 0x40002184;
__addsf3 = 0x40002190;
__addvdi3 = 0x4000219c;
__addvsi3 = 0x400021a8;
__ashldi3 = 0x400021b4;
__ashrdi3 = 0x400021c0;
__bswapdi2 = 0x400021cc;
__bswapsi2 = 0x400021d8;
__clear_cache = 0x400021e4;
__clrsbdi2 = 0x400021f0;
__clrsbsi2 = 0x400021fc;
__clzdi2 = 0x40002208;
__clzsi2 = 0x40002214;
__cmpdi2 = 0x40002220;
__ctzdi2 = 0x4000222c;
__ctzsi2 = 0x40002238;
__divdc3 = 0x40002244;
__divdf3 = 0x40002250;
__divdi3 = 0x4000225c;
__divsc3 = 0x40002268;
__divsf3 = 0x40002274;
__divsi3 = 0x40002280;
__eqdf2 = 0x4000228c;
__eqsf2 = 0x40002298;
__extendsfdf2 = 0x400022a4;
__ffsdi2 = 0x400022b0;
__ffssi2 = 0x400022bc;
__fixdfdi = 0x400022c8;
__fixdfsi = 0x400022d4;
__fixsfdi = 0x400022e0;
__fixsfsi = 0x400022ec;
__fixunsdfsi = 0x400022f8;
__fixunssfdi = 0x40002304;
__fixunssfsi = 0x40002310;
__floatdidf = 0x4000231c;
__floatdisf = 0x40002328;
__floatsidf = 0x40002334;
__floatsisf = 0x40002340;
__floatundidf = 0x4000234c;
__floatundisf = 0x40002358;
__floatunsidf = 0x40002364;
__floatunsisf = 0x40002370;
__gcc_bcmp = 0x4000237c;
__gedf2 = 0x40002388;
__gesf2 = 0x40002394;
__gtdf2 = 0x400023a0;
__gtsf2 = 0x400023ac;
__ledf2 = 0x400023b8;
__lesf2 = 0x400023c4;
__lshrdi3 = 0x400023d0;
__ltdf2 = 0x400023dc;
__ltsf2 = 0x400023e8;
__moddi3 = 0x400023f4;
__modsi3 = 0x40002400;
__muldc3 = 0x4000240c;
__muldf3 = 0x40002418;
__muldi3 = 0x40002424;
__mulsc3 = 0x40002430;
__mulsf3 = 0x4000243c;
__mulsi3 = 0x40002448;
__mulvdi3 = 0x40002454;
__mulvsi3 = 0x40002460;
__nedf2 = 0x4000246c;
__negdf2 = 0x40002478;
__negdi2 = 0x40002484;
__negsf2 = 0x40002490;
__negvdi2 = 0x4000249c;
__negvsi2 = 0x400024a8;
__nesf2 = 0x400024b4;
__paritysi2 = 0x400024c0;
__popcountdi2 = 0x400024cc;
__popcountsi2 = 0x400024d8;
__powidf2 = 0x400024e4;
__powisf2 = 0x400024f0;
__subdf3 = 0x400024fc;
__subsf3 = 0x40002508;
__subvdi3 = 0x40002514;
__subvsi3 = 0x40002520;
__swbuf = 0x40001554;
__truncdfsf2 = 0x4000252c;
__ucmpdi2 = 0x40002538;
__udiv_w_sdiv = 0x40002568;
__udivdi3 = 0x40002544;
__udivmoddi4 = 0x40002550;
__udivsi3 = 0x4000255c;
__umoddi3 = 0x40002574;
__umodsi3 = 0x40002580;
__unorddf2 = 0x4000258c;
__unordsf2 = 0x40002598;

isalnum = 0x40001284;
isalpha = 0x40001290;
isascii = 0x4000129c;
isblank = 0x400012a8;
iscntrl = 0x400012b4;
isdigit = 0x400012c0;
isgraph = 0x400012d8;
islower = 0x400012cc;
isprint = 0x400012e4;
ispunct = 0x400012f0;
isspace = 0x400012fc;
isupper = 0x40001308;
itoa = 0x400014c4;

labs = 0x40001470;
ldiv = 0x4000147c;

memccpy = 0x40001338;
memchr = 0x40001344;
memcmp = 0x4000120c;
memcpy = 0x400011f4;
memmove = 0x40001200;
memrchr = 0x40001350;
memset = 0x400011e8;
multofup = 0x400006cc;

qsort = 0x40001488;

rand = 0x400014a0;
rand_r = 0x40001494;

srand = 0x400014ac;
strcasecmp = 0x4000135c;
strcasestr = 0x40001368;
strcat = 0x40001374;
strchr = 0x4000138c;
strcmp = 0x40001230;
strcoll = 0x400013a4;
strcpy = 0x40001218;
strcspn = 0x40001398;
strdup = 0x40001380;
strlcat = 0x400013b0;
strlcpy = 0x400013bc;
strlen = 0x40001248;
strlwr = 0x400013c8;
strncasecmp = 0x400013d4;
strncat = 0x400013e0;
strncmp = 0x4000123c;
strncpy = 0x40001224;
strndup = 0x400013ec;
strnlen = 0x400013f8;
strrchr = 0x40001404;
strsep = 0x40001410;
strspn = 0x4000141c;
strstr = 0x40001254;
strtok_r = 0x40001428;
strtol = 0x400014e8;
strtoul = 0x400014f4;
strupr = 0x40001434;

toascii = 0x4000132c;
tolower = 0x40001320;
toupper = 0x40001314;

utoa = 0x400014b8;

SECTIONS
{
  .text %TEXT_START% : {
        *(.theader)
        *(.literal)
        *(.text)
        . = ALIGN(4);
  }

  .data %DATA_START% : {
       *(.dheader)
       *(.data)
       *(.rodata*)
       . = ALIGN(8);
  }

  .bss %BSS_START% : {
       *(.bss)
       . = ALIGN(8);
  }
}
