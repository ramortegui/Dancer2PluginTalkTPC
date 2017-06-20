#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use MyWebStore;

MyWebStore->to_app;

use Plack::Builder;

builder {
    enable 'Deflater';
    MyWebStore->to_app;
}



=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use MyWebStore;
use Plack::Builder;

builder {
    enable 'Deflater';
    MyWebStore->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use MyWebStore;
use MyWebStore_admin;

builder {
    mount '/'      => MyWebStore->to_app;
    mount '/admin'      => MyWebStore_admin->to_app;
}

=end comment

=cut

