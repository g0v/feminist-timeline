#!/usr/bin/env perl -w

use Mojo::UserAgent;
use v5.020;

binmode STDOUT, ":utf8";

my $url = "https://women.nmth.gov.tw/events_40.html";

my $ua = Mojo::UserAgent->new;
my $ul = $ua->get($url)
    ->result
    ->dom
    ->at(".timeline-v2");

for my $li (@{$ul->children}) {
    my $year = $li->find(".cbp_tmtime")->first->all_text;
    chomp($year);
    $year =~ s/(年|\s)//g;
    for my $item (@{$li->find("p")}) {
        my $text = $item->text; chomp($text);
        $text =~ s/^.*?\d{4}\s*//s;
        $text =~ s/\s*//g;
        say "$year,$text";
    }
}

=head1 NAME

get.pl - grab data from L<https://women.nmth.gov.tw/events_40.html>

=head1 SYNOPSIS

    ./get.pl

=cut
