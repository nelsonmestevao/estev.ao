module.exports = {
  extends: ['airbnb', 'plugin:prettier/recommended'],
  env: {
    browser: true,
  },
  parser: 'babel-eslint',
  rules: {
    indent: 0,
    camelcase: ['error', { properties: 'always' }],
    'eol-last': ['error', 'always'],
    'func-names': 0,
    'no-console': 0,
    'no-tabs': 0,
    'no-underscore-dangle': 0,
    'react/forbid-prop-types': 0,
    'react/jsx-filename-extension': 0,
    'react/jsx-one-expression-per-line': 0,
    'react/jsx-wrap-multilines': 0,
    'react/no-unescaped-entities': 0,
    'react/react-in-jsx-scope': 'off',
    'react/require-default-props': 0,
  },
};
