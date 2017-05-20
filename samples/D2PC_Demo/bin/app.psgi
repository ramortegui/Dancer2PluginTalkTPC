#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use D2PC_Demo;

D2PC_Demo->to_app;

use Plack::Builder;

builder {
    enable 'Deflater';
    D2PC_Demo->to_app;
}



=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use D2PC_Demo;
use Plack::Builder;

builder {
    enable 'Deflater';
    D2PC_Demo->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use D2PC_Demo;
use D2PC_Demo_admin;

builder {
    mount '/'      => D2PC_Demo->to_app;
    mount '/admin'      => D2PC_Demo_admin->to_app;
}

=end comment

=cut

