const CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {

	mode: 'development',

	entry: './index.ts',
	output: {
		filename: 'runtime.js',
		path: __dirname
	},

	devtool: 'source-map',

	resolve: {
		extensions: ['.ts', '.tsx', '.js', '.json']
	},

	module: {
		rules: [
			{
				test: /\.tsx?$/,
				loader: 'ts-loader',
				options: {
					transpileOnly: true
				}
			}
		]
	},

	plugins: [
		new CopyWebpackPlugin([
			{ from: './runtime.js', to: '../ios/Dezel/Dezel/Modules/Web/WebRuntime.js', force: true },
			{ from: './runtime.js', to: '../android/Dezel/dezel/src/main/res/raw/web_runtime.js', force: true }
		])
	]
};
