// See http://brunch.io for documentation.
//
exports.files = {
  javascripts: { joinTo: 'js/app.js' },
  stylesheets: {joinTo: 'css/app.css'}
};

exports.plugins = {
  babel: {presets: ['latest']}
};

exports.paths = {
  watched: ['app','views']
};

exports.npm = {
  aliases: {
    vue: "vue/dist/vue.js",
  }
};
