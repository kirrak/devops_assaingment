/** @type {import('eslint').Linter.Config} */
module.exports = [
    {
      // Define plugins as an object
      plugins: {
        'eslint-plugin-node': require('eslint-plugin-node'), // Correct format: plugin as an object
      },
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