export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  routeRules: {
    // Opcional: puedes decirle a ciertas rutas que se ejecuten solo del lado cliente
    '/auth': { ssr: false },
    '/': { ssr: false }, 
    '/agregar': { ssr: false },
    '/calendario': { ssr: false },
    '/perfil': { ssr: false }
  },
  css: [
    // Este puede quedar por si las dudas
    'quasar/dist/quasar.css',
    '@quasar/extras/material-icons/material-icons.css',
    '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
  ],
  modules: [
    '@nuxt/fonts',
    '@nuxt/eslint',
    '@pinia/nuxt',
    '@nuxt/icon',
    '@nuxt/image',
    '@nuxt/scripts',
    '@nuxt/test-utils',
    'nuxt-quasar-ui',
    '@pinia/nuxt',
    '@vueuse/nuxt'
  ],
  quasar:{
    plugins: ['Notify'],
    lang: 'es'
  },

  build: {
    transpile: ['quasar'],
  },

  vite: {
    define: {
      'process.env.DEBUG': 'false',
    },
  },
})