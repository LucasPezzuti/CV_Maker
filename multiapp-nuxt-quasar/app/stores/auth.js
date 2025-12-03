// stores/auth.js
import { defineStore } from 'pinia'
import { useLocalStorage } from '@vueuse/core'

export const useAuthStore = defineStore('auth', () => {
  const user = useLocalStorage('auth-user', null)
  const token = useLocalStorage('auth-token', null)

  async function login(credentials) {
    try {
      const response = await $fetch('http://localhost:8000/api/login', {
        method: 'POST',
        body: credentials,
      })
      //console.log(response.user,'aasdasdasd');
      user.value = response.user.name
      //console.log(user.value);
      token.value = response.token

      //console.log('Token:', token.value)
      //console.log('Guardado en localStorage:', localStorage.getItem('auth-token'))

      return true
    } catch (error) {
      //clearAuthData()
      throw error
    }
  }

  function clearAuthData() {
    user.value = null
    token.value = null
  }

  return {
    user,
    token,
    login,
    clearAuthData,
  }
})
