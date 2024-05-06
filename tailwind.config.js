module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      spacing: {
        17: "4.25rem", // ここで '17' の値を追加
        18: "4.5rem", // 必要に応じて他の値も追加可能
      },
    },
  },
  plugins: [require("daisyui")],
};
