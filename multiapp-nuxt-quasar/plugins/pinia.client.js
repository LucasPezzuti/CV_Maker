// plugins/pinia.client.ts
import { defineNuxtPlugin } from '#app'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'

export default defineNuxtPlugin(({ $pinia }) => {
  // $pinia ya está creado por @pinia/nuxt
  $pinia.use(piniaPluginPersistedstate)
})