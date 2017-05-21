package D2PC_Demo;
use Dancer2;
use Dancer2::Plugin::Cart;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'D2PC_Demo' };
};

hook 'plugin.cart.products' => sub {
  my $ec_cart = session('ec_cart');
  $ec_cart->{products} = [
    { ec_sku => "book1", ec_price => 10 },
    { ec_sku => "book2", ec_price => 15 },
  ];
  session "ec_cart" => $ec_cart;
};

hook 'plugin.cart.adjustments' => sub {
  my $ec_cart = session("ec_cart");
  $ec_cart->{cart}->{adjustments} = [];
  session "ec_cart" => $ec_cart;
};

hook 'after' => sub {
  debug(to_dumper(session('ec_cart')));
  debug(to_dumper( scalar(@{session('ec_cart')->{cart}->{items}}) ));
};


true;
