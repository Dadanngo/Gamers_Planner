module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        mplus: ['M PLUS 1p', 'serif'],
        Rajdhani: ['Rajdhani', 'serif']
      },
      animation: {
        "scale-up-hor-left": "scale-up-hor-left 1s cubic-bezier(0.390, 0.575, 0.565, 1.000) both",
        wiggle: 'wiggle 1s ease-in-out infinite',
      },
      keyframes: {
        "scale-up-hor-left": {
          "0%": {
            transform: "scaleX(.4)",
            "transform-origin": "0% 0%"
          },
          to: {
            transform: "scaleX(1)",
            "transform-origin": "0% 0%"
          }
        },
        wiggle: {
          '0%, 100%': { transform: 'rotate(-3deg)' },
          '50%': { transform: 'rotate(3deg)' },
        },
      }
    }
  }
}