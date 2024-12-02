/** @type {import('eslint').Linter.Config} */
module.exports = {
    extends: ['../../.eslintrc.json'], // Inherit from the root configuration
  
    ignorePatterns: ['!**/*'], // Similar to "ignorePatterns" in .eslintrc.json
  
    overrides: [
      {
        files: ['*.ts', '*.tsx', '*.js', '*.jsx'],
        rules: {} // You can add custom rules for all these file types if needed
      },
      {
        files: ['*.ts', '*.tsx'],
        rules: {} // Custom rules for TypeScript files (if needed)
      },
      {
        files: ['*.js', '*.jsx'],
        rules: {} // Custom rules for JavaScript files (if needed)
      }
    ]
  };
  