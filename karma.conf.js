// Karma configuration
// Generated on Thu Jul 04 2019 15:04:10 GMT-0400 (GMT-04:00)

module.exports = function (config) {
  config.set({

    basePath: './',

    frameworks: ['jasmine', 'karma-typescript'],
    reporters: ['progress', 'karma-typescript'],
    browsers: [],

    files: [
      'src/**/*.ts',
      'src/**/*.tsx',
      'src/**/*.test.ts',
      'src/**/*.test.tsx'
    ],


    exclude: [
    ],

    preprocessors: {
      "**/*.ts": "karma-typescript",
      "**/*.tsx": "karma-typescript"
    },


    karmaTypescriptConfig: {
      tsconfig: './tsconfig.json',
    },

    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    singleRun: false,
    concurrency: 1,

  })
}
