/** @type {import('eslint').Linter.Config} */
module.exports = [
    {
      plugins: {
        'eslint-plugin-node': require('eslint-plugin-node') // Make sure the plugin is included here
      },
      rules: {
        // Add your custom rules here
      },
      files: ['*.ts', '*.tsx', '*.js', '*.jsx'],
      languageOptions: {
        ecmaVersion: 'latest',
        sourceType: 'module',
      }
    }
  ];
  