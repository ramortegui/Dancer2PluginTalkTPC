package D2PC_SPA::API;
use Dancer2;
use Dancer2::Plugin::Cart;
set serializer => 'JSON';

hook 'plugin.cart.products' => sub {
  my $ec_cart = session('ec_cart');
  $ec_cart->{products} = [
    { ec_sku =>'SU01',ec_price => 10 },
    { ec_sku =>'SU02',ec_price => 15 },
  ];
  session "ec_cart" => $ec_cart;
};

get '/products' => sub {
  products
};

true;
