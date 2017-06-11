package D2PC_SPA::API;
use Dancer2;
use Dancer2::Plugin::Cart;
set serializer => "JSON";

hook 'plugin.cart.products' => sub {
  my $ec_cart = session('ec_cart');
  $ec_cart->{products} = [
    { ec_sku =>'SU01',ec_price => 10 },
    { ec_sku =>'SU02',ec_price => 15 },
  ];
  session "ec_cart" => $ec_cart;
};

get '/cart' => sub {
  products;
  cart;
};

post '/cart/add' => sub {
  my $params = params;
  cart_add_item($params);
  cart
};

true;
