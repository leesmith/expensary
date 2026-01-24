# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@tailwindplus/elements", to: "@tailwindplus--elements.js" # @1.0.22
pin "@tailwindcss/forms", to: "@tailwindcss--forms.js" # @0.5.11
pin "mini-svg-data-uri" # @1.4.4
pin "tailwindcss/colors", to: "tailwindcss--colors.js" # @4.1.18
pin "tailwindcss/defaultTheme", to: "tailwindcss--defaultTheme.js" # @4.1.18
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @4.1.18
pin "el-transition" # @0.0.7
pin "echarts", to: "echarts.min.js"
pin "echarts/theme/dark", to: "echarts/theme/dark.js"
pin "tailwindcss" # @4.1.18
