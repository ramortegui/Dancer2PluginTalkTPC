package D2PC_SPA::API;
use Dancer2;
use Dancer2::Plugin::Cart;
set serializer => 'JSON';


get '/products' => sub {
  products
};

get '/cart' => sub {
  cart;
};

post '/cart/add' => sub {
  cart_add
  cart
};

true;
