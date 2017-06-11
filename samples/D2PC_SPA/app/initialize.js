document.addEventListener('DOMContentLoaded', () => {
  // do your setup here
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
    } 
  },
  created: function () {
    this.fetchData();
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
    },
    fetchData: function () {
      var xhr = new XMLHttpRequest()
        var self = this
        xhr.open('GET', '/api/cart')
        xhr.onload = function () {
          self.ec_cart = JSON.parse(xhr.responseText);
        };
      xhr.send()
    },
  }
});

