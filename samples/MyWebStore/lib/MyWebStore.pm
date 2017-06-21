package MyWebStore;
use Dancer2;
use Dancer2::Plugin::Cart;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'MyWebStore' };
};

hook 'plugin.cart.products' => sub {
  my $ec_cart = session('ec_cart');
  @{$ec_cart->{products}} = (
    {
      ec_sku => 'PERLBOOK',
      ec_price => 45
    } 
  );
  session 'ec_cart' => $ec_cart;
};

hook 'plugin.cart.validate_shipping_params' => sub {
  my $ec_cart = session('ec_cart');
  if( $ec_cart->{shipping}->{form}->{email} =~ /fake\.com$/ ){
    push @{$ec_cart->{shipping}->{error}}, 'Domain banned';
  }
  session 'ec_cart' => $ec_cart;
};

hook 'plugin.cart.adjustments' => sub {
  my $ec_cart = session('ec_cart');
  @{$ec_cart->{cart}->{adjustments}} = ();
  session 'ec_cart' => $ec_cart;
};

hook 'plugin.cart.checkout' => sub {
  debug('CC authorization | charge ');
  debug('Log/Place Order');
  debug('Send notifications');
};

hook 'after' => sub {
  debug(to_dumper(cart));
};
true;
