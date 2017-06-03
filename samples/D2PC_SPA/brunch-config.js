// See http://brunch.io for documentation.
exports.files = {
  javascripts: {
    joinTo: {
      'javascripts/vendor.js': /^(?!app)/, // Files that are not in `app` dir.
      'javascripts/app.js': /^app/
    }
  },
  stylesheets: {joinTo: 'css/app.css'}
};

exports.plugins = {
  babel: {presets: ['latest']}
};
