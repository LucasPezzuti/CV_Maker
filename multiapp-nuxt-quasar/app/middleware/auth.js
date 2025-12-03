import { useAuthStore } from '~/stores/auth'

export default defineNuxtRouteMiddleware((to, from) => {
  const auth = useAuthStore()

  console.log('[Middleware] Ruta destino:', to.path)
  console.log('[Middleware] Token actual:', auth.token)
  console.log('[Middleware] localStorage:', process.client ? localStorage.getItem('auth-token') : 'SSR')

  if (process.client) {
    // Token no existe y no está en /auth => redirigí
    if (!auth.token && to.path !== '/auth') {
      console.log('[Middleware] No hay token. Redirigiendo a /auth')
      return navigateTo('/auth')
    }

    // Ya logueado e intenta ir a /auth => mandalo a /
    if (auth.token && to.path === '/auth') {
      console.log('[Middleware] Ya hay token. Redirigiendo a /')
      return navigateTo(to.path)
    }
  } else {
    console.log('[Middleware] Ejecutando en SSR, omitiendo redirección')
  }
})
