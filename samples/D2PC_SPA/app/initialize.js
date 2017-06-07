document.addEventListener('DOMContentLoaded', () => {
  // do your setup here
  console.log('Initialized app');
});
import Vue from 'vue';
new Vue({
  el: "#products",
  data: {
    products: [] 
  },
  created: function () {
    this.fetchData()
  },
  methods: {
    fetchData: function () {
      var xhr = new XMLHttpRequest()
        var self = this
        xhr.open('GET', '/api/products')
        xhr.onload = function () {
          self.products = JSON.parse(xhr.responseText)
            console.log(self.products)
        }
      xhr.send()
    }
  },
});


