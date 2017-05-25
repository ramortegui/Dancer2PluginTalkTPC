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

hook 'plugin.cart.validate_shipping_params' => sub {
  my $ec_cart = session("ec_cart");
  if ( $ec_cart->{shipping}->{form}->{email} =~ /fake\.com$/ ){
    push @{$ec_cart->{shipping}->{error}},"Emails from fake.com aren't valid.";
  }
  session "ec_cart" => $ec_cart;
};

hook 'plugin.cart.adjustments' => sub {
  my $ec_cart = session("ec_cart");
  $ec_cart->{cart}->{adjustments} = [];
  session "ec_cart" => $ec_cart;
};

true;
