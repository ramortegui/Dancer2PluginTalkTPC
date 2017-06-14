document.addEventListener('DOMContentLoaded', () => {
  console.log('Initialized app');
});


import Vue from 'vue';
var products = new Vue({
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
      var xhr = new XMLHttpRequest();
      var self = this;
      xhr.open('GET', '/api/cart');
      xhr.onload = function () {
        self.ec_cart= JSON.parse(xhr.responseText);
      }
      xhr.send();
    },
    cartadd: function (ec_sku, qty) {
      var xhr = new XMLHttpRequest();
      xhr.open('POST', '/api/cart/add');
      xhr.setRequestHeader("Content-type", "application/json");
      var query = JSON.stringify({ ec_sku: ec_sku, ec_quantity: qty });
      xhr.send(query);
      this.loadcart();
      this.message = {};
    },
    purchase: function(){ 
      let products_instance = this; 
      var handler = StripeCheckout.configure({
      key: 'pk_test_WLyvEGvLYs8BLqODNs4dOfOa',
      locale: 'auto',
      token: function (token) {
          var xhr = new XMLHttpRequest();
          xhr.open('POST', '/api/purchase');
          xhr.setRequestHeader("Content-type", "application/json");
          var query = JSON.stringify({ token: token.id });
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
