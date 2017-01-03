var config = require("./webpack.config.js");
var webpack = require( "webpack");

config.plugins = [
  new webpack.optimize.DedupePlugin(),
  new webpack.optimize.UglifyJsPlugin({
    minimize: true
    compress: {
      warnings: false
    }
  }),
  new webpack.DefinePlugin({
    'process.env': {
      'NODE_ENV': JSON.stringify('production')
    }
  })
];
config.devtool = 'cheap-module-source-map';

module.exports = config;
