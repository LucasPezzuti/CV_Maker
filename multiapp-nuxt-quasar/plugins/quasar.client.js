import { Quasar, Notify } from 'quasar' // Importa Notify explícitamente
import quasarLang from 'quasar/lang/es'
import 'quasar/dist/quasar.css'
import '@quasar/extras/material-icons/material-icons.css'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
import '@quasar/extras/material-icons-outlined/material-icons-outlined.css'
import '@quasar/extras/material-icons-round/material-icons-round.css'
import '@quasar/extras/material-icons-sharp/material-icons-sharp.css'
import '@quasar/extras/mdi-v6/mdi-v6.css' // ✅ para usar mdi-google

export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.vueApp.use(Quasar, {
    plugins: { Notify }, // ✅ Notify ahora está registrado
    lang: quasarLang,
  })
})