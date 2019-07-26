const path = require('path')
const CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {

	mode: 'development',

	entry: './index.ts',
	output: {
		filename: 'TestRunner.js',
		path: path.join(__dirname, 'dist')
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
			{ from: './dist/TestRunner.js', to: '../ios/Dezel/Dezel/Test/TestRunner.js', force: true },
			//{ from: './runtime.js', to: '../android/Dezel/dezel/src/main/res/raw/web_runtime.js', force: true }
		])
	]
};
