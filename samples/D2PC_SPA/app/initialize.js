
import Vue from 'vue';
document.addEventListener('DOMContentLoaded', () => {
  let products = new Vue({
    el: "#ec_cart",
    data: {
      ec_cart: {
        cart: {
          items: []
        },
        products: []
      },
      message: {} 
    },
    created: function () {
      this.loadcart();
    },
    methods: {
      loadcart: function() {
        let xhr = new XMLHttpRequest();
        let self = this;
        xhr.open('GET', '/api/cart');
        xhr.onload = function () {
          self.ec_cart= JSON.parse(xhr.responseText);
        }
        xhr.send();
      },
      cartadd: function (ec_sku, qty) {
        let xhr = new XMLHttpRequest();
        xhr.open('POST', '/api/cart/add');
        xhr.setRequestHeader("Content-type", "application/json");
        let query = JSON.stringify({ ec_sku: ec_sku, ec_quantity: qty });
        xhr.send(query);
        this.loadcart();
        this.message = {};
      },
      purchase: function(){ 
        let products_instance = this; 
        let handler = StripeCheckout.configure({
        key: 'pk_test_WLyvEGvLYs8BLqODNs4dOfOa',
        locale: 'auto',
        token: function (token) {
            let xhr = new XMLHttpRequest();
            xhr.open('POST', '/api/purchase');
            xhr.setRequestHeader("Content-type", "application/json");
            let query = JSON.stringify({ token: token.id });
            xhr.send(query);
            xhr.onload = function () {
             products_instance.message = JSON.parse(xhr.responseText);
            }
          },
        closed: function (){
          products_instance.loadcart();
        }
        });
        let stripeAmount = this.ec_cart.cart.total * 100; // integer, in the smallest currency unit
        let displayAmount = (stripeAmount / 100).toFixed(2);
        let panelLabel = "Purchase"// displayAmount;
        // Open Checkout with further options
        handler.open({
          name: 'D2PC_SPA',
          description: 'Services',
          panelLabel: panelLabel
        });
      },
    }
  });
});

