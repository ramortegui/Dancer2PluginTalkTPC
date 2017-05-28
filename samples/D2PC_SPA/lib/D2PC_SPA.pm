package D2PC_SPA;
use Dancer2;
use Dancer2::Plugin::Cart;

our $VERSION = '0.1';

get '/' => sub {
  template 'index' => { 'title' => 'D3PC_SPA', 'product_list' => products };
};

true;
