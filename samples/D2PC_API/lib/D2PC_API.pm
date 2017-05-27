package D2PC_API;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'D2PC_API' };
};

true;
