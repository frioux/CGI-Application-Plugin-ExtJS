package CGI::Application::Plugin::ExtJS;

# ABSTRACT: Convert paginated DBIx::Class::ResultSet's to JSON-style structures

use strict;
use warnings;

require Exporter;

use base qw(Exporter AutoLoader);

our @EXPORT_OK   = qw(&ext_paginate);
our %EXPORT_TAGS = (all => [@EXPORT_OK]);

sub ext_paginate {
   my $self     = shift;
   my $resultset = shift;
   my $method = shift || 'TO_JSON';
   # param names should be configurable
   return {
      data => [map $_->$method, $resultset->all],
      total => $resultset->pager->total_entries,
   };
}

1;

=pod

=head1 SYNOPSIS

  use CGI::Application::Plugin::ExtJS 'ext_paginate';

  sub people {
     # ...
     my $json = $self->ext_paginate($paginated_rs);
     # ...
  }

  sub people_lite {
     # ...
     my $json = $self->ext_paginate($paginated_rs, sub {
        my $person = shift;
        return {
           first_name => $person->first_name,
           last_name => $person->last_name,
        }
     });
     # ...
  }

  # this will call the 'foo' method on each person and put the returned
  # value into the datastructure
  sub people_more_different {
     # ...
     my $json = $self->ext_paginate($paginated_rs, 'foo');
     # ...
  }


=head1 DESCRIPTION

This module is mostly for sending paginated data to ExtJS based javascript code.

=head1 METHODS

=head2 ext_paginate

  my $resultset = $self->schema->resultset('Foo');
  my $results   = $self->paginate($resultset);
  my $json      = $self->ext_paginate($resultset);
  my $json_str  = to_json($json);

=head3 Description

Returns a structure like the following from the ResultSet:

  {
     data  => [@results],
     total => $count_before_pagination
  }

=head3 Valid arguments are:

  rs      - paginated ResultSet to get the data from
  coderef - any valid scalar that can be called on the result object

=head1 SEE ALSO

L<CGI::Application::Plugin::DBIx::Class>.

=cut

__END__
