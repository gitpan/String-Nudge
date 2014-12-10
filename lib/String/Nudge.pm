package String::Nudge;
$String::Nudge::VERSION = '0.0100';
use strict;
use warnings;
use 5.010000;

use Sub::Exporter::Progressive -setup => {
    exports => [qw/nudge/],
    groups => {
        default => [qw/nudge/],
    },
};

sub nudge ($;$) {
    my $first = shift;
    my $second = shift;

    my $indent = 4;
    my $string;

    if(defined $second) {
        if(int $first eq $first && int $first >= 0) {
            $indent = int $first;
            $string = $second;
        }
        else {
            warnings::warn(numeric => q{first argument to nudge isn't numeric.});
            $string = $second;
        }
    }
    else {
        $string = $first;

    }
    my $nudgement = ' ' x $indent;

    $string =~ s{^(?=\V)}{$nudgement}gms;
    $string =~ s{^\h*$}{}gms;
    return $string;
}


1;

__END__

=encoding utf-8

=head1 NAME

String::Nudge - Nudges all lines in a multi-line string

=head1 SYNOPSIS

    use String::Nudge;

    sub out {
        print nudge q{
            A long
            text.
        };
    }

    # is exactly the same as
    sub out {
        print q{
                A long
                text.
    };
    }


=head1 DESCRIPTION

String::Nudge provides C<nudge>, a simple function that indents all lines in a multi line string.

=head2 METHODS

=head3 nudge $string

    # '    hello'
    my $string = nudge 'hello';

=head3 nudge $number_of_spaces, $string

    # '        hello'
    my $string = nudge 8, 'hello';

If C<$number_of_spaces> is not given (or isn't an integer >= 0) its default value is C<4>.

Every line in C<$string> is indented by C<$number_of_spaces>. Lines only consisting of white space is trimmed (but not removed).

C<nudge> works nicely together with L<qi|Syntax::Feature::Qi>:

    # these three packages are equivalent:
    package Example::Nudge {

        use String::Nudge;
        use syntax 'qi';

        sub out {
            print nudge qi{
                sub funcname {
                    print 'stuff';
                }
            };
        }
    }
    package Example::Q {

        sub out {
            print q{
        sub funcname {
            print 'stuff';
        }
    };
        }
    }
    package Example::HereDoc {

        sub out {

            (my $text = <<"        END") =~ s{^ {8}}{}gm;
                sub funcname {
                    print 'stuff';
                }
            END

            print $text;
        }
    }

=head1 SEE ALSO

=over 4

=item L<Indent::String>

=item L<String::Indent>

=item L<qi|Syntax::Feature::Qi>

=back

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
