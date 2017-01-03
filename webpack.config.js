module.exports = {
  devtool: "cheap-module-source-map",
  entry: "./webpackJavascripts/entry.js",
  output: {
    // we're going to put the generated file in the assets folder so jekyll will grab it.
      path: './javascript/',
      filename: "bundle.js"
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules)/,
        loader: 'babel', // 'babel-loader' is also a legal name to reference
        query: {
          presets: ['react', 'es2015']
        }
      }
    ]
  }
};
