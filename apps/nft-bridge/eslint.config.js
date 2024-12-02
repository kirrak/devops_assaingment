/** @type {import('eslint').Linter.Config} */
module.exports = [
    {
      // Include configurations directly instead of using "extends"
      plugins: ['eslint-plugin-node'], // Example plugin
      rules: {
        // Place your custom rules here
      },
      overrides: [
        {
          files: ['*.ts', '*.tsx', '*.js', '*.jsx'],
          rules: {},
        },
        {
          files: ['*.ts', '*.tsx'],
          rules: {},
        },
        {
          files: ['*.js', '*.jsx'],
          rules: {},
        },
      ],
    },
  ];
  