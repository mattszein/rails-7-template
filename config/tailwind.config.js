const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,rb,html}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Roboto', ...defaultTheme.fontFamily.sans],
      },
      fontSize: {
        sm: ['16px', '24px'],
        md: ['20px', '30px'],
        base: ['20px', '30px'],
        lg: ['24px', '32px'],
        xl: ['28px', '36px'],
      },
      colors: {
        brand: "#FD4F00",
        primary: colors.indigo,
        secondary: colors.pink,
        success: colors.green,
        danger: colors.red,
        warning: colors.yellow,
        info: colors.sky,
        create: colors.green,
        show: colors.blue,
        edit: colors.yellow,
        update: colors.orange,
        delete: colors.red,
        // Options: slate, gray, zinc, neutral, stone
        gray: colors.gray,
      }
    },
  },
  darkMode: ['class', '[data-mode="dark"]'],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
