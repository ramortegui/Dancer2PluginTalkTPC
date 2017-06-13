package D2PC_SPA::API;
use Dancer2;
use Dancer2::Plugin::Cart;
use Net::Stripe;
set serializer => "JSON";

hook 'plugin.cart.products' => sub {
  my $ec_cart = session('ec_cart');
  $ec_cart->{products} = [
    { ec_sku =>'SU01',ec_price => 10 },
    { ec_sku =>'SU02',ec_price => 15 },
  ];
  session "ec_cart" => $ec_cart;
};

hook 'plugin.cart.adjustments' => sub {
  my $ec_cart = session('ec_cart');
  $ec_cart->{cart}->{adjustments} = [];
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

post '/purchase' => sub {
  my $ec_cart = cart;
  my $params = params;
  my $stripe     = Net::Stripe->new(api_key => config->{stripe_key});
  my $card_token = $params->{token};
  my $charge = $stripe->post_charge(  # Net::Stripe::Charge
    amount      => $ec_cart->{cart}->{total} * 100,
    currency    => 'usd',
    card        => $card_token,
    description => 'Payment',
  );
  my $response = {};
  if( $charge->paid ){
    clear_cart;
    $response = { status => "ok", message => "Payment Success!!" };
  }
  else{
    $response = { status => "fail", message => "Payment error" };
  }
  return $response;
};

true;
