<template>
  <q-page class="window-height window-width row justify-center items-center"
    style="background: linear-gradient(#8274C5, #5A4A9F);">
    <!-- Contenedor principal -->
    <div class="column q-pa-lg">
      <div class="row">
        <!-- Tarjeta dinámica -->
        <q-card square class="shadow-24" style="width:300px;height:485px;">
          <!-- Login Form (visible cuando showLogin es true) -->
          <template v-if="showLogin">
            <q-card-section class="bg-deep-purple-7">
              <h4 class="text-h5 text-white q-my-md">ChocoFoodies!</h4>
              <div class="absolute-bottom-right q-pr-md" style="transform: translateY(50%);">
                <q-btn 
                  fab 
                  icon="add" 
                  color="purple-4" 
                  size="lg"
                  class="absolute-bottom-right q-mr-md q-mb-md"
                  @click="showLogin = false"
                />
              </div>
            </q-card-section>
            <q-card-section>
              <q-form class="q-px-sm q-pt-xl" @submit.prevent="handleLogin">
                <q-input 
                  square 
                  clearable 
                  v-model="loginEmail" 
                  type="email" 
                  label="Email"
                  lazy-rules
                  :rules="[val => !!val || 'Email es requerido', isValidEmail]"
                  required
                >
                  <template v-slot:prepend>
                    <q-icon name="email" />
                  </template>
                </q-input>
                <q-input 
                  square 
                  clearable 
                  v-model="loginPassword" 
                  type="password" 
                  label="Password"
                  lazy-rules
                  :rules="[val => !!val || 'Contraseña es requerida']"
                  required
                >
                  <template v-slot:prepend>
                    <q-icon name="lock" />
                  </template>
                </q-input>
              </q-form>
            </q-card-section>

            <q-card-actions class="q-px-lg">
              <q-btn 
                unelevated 
                size="lg" 
                color="purple-4" 
                class="full-width text-white" 
                label="Ingresa" 
                type="submit"
                @click="handleLogin"
                :loading="loadingLogin"
              />
            </q-card-actions>
            <div class="text-center q-pb-sm">
              <q-btn 
                flat 
                color="white" 
                label="¿Olvidaste tu contraseña?" 
                @click="handleForgotPassword"
                size="sm"
              />
            </div>
          </template>

          <!-- Register Form (visible cuando showLogin es false) -->
          <template v-else>
            <q-card-section class="bg-deep-purple-7">
              <h4 class="text-h5 text-white q-my-md">ChocoFoodies!</h4>
              <div class="absolute-bottom-right q-pr-md" style="transform: translateY(50%);">
                <q-btn 
                  fab 
                  icon="close" 
                  color="purple-4" 
                  size="lg"
                  class="absolute-bottom-right q-mr-md q-mb-md"
                  @click="showLogin = true"
                />
              </div>
            </q-card-section>
            <q-card-section>
              <q-form class="q-px-sm q-pt-xl q-pb-lg" @submit.prevent="handleRegister">
                <q-input 
                  square 
                  clearable 
                  v-model="registerEmail" 
                  type="email" 
                  label="Email"
                  lazy-rules
                  :rules="[val => !!val || 'Email es requerido', isValidEmail]"
                  required
                >
                  <template v-slot:prepend>
                    <q-icon name="email" />
                  </template>
                </q-input>
                <q-input 
                  square 
                  clearable 
                  v-model="registerName" 
                  type="text" 
                  label="Nombre"
                  lazy-rules
                  :rules="[val => !!val || 'Nombre es requerido']"
                  required
                >
                  <template v-slot:prepend>
                    <q-icon name="person" />
                  </template>
                </q-input>
                <q-input 
                  square 
                  clearable 
                  v-model="registerPassword" 
                  type="password" 
                  label="Password"
                  lazy-rules
                  :rules="[val => !!val || 'Contraseña es requerida', val => val.length >= 6 || 'Mínimo 6 caracteres']"
                  required
                >
                  <template v-slot:prepend>
                    <q-icon name="lock" />
                  </template>
                </q-input>
                <q-input 
                  square 
                  clearable
                  class="sinpadding" 
                  v-model="registerPasswordConfirm" 
                  type="password" 
                  label="Confirma el Password"
                  lazy-rules
                  :rules="[val => !!val || 'Confirma tu contraseña', val => val === registerPassword || 'Las contraseñas no coinciden']"
                  required
                >
                  <template v-slot:prepend>
                    <q-icon name="lock" />
                  </template>
                </q-input>
              </q-form>
            </q-card-section>
            <q-card-actions class="q-px-lg">
              <q-btn 
                unelevated 
                size="lg" 
                color="purple-4" 
                class="full-width text-white" 
                label="Registrate" 
                type="submit"
                @click="handleRegister"
                :loading="loadingRegister"
              />
            </q-card-actions>
          </template>
        </q-card>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref } from 'vue'
import { useAuthStore } from '~/stores/auth'

const $q = useQuasar()

definePageMeta({
  layout: 'public'
})

// Estado para controlar qué formulario mostrar
const showLogin = ref(true)

// Estados de carga
const loadingLogin = ref(false)
const loadingRegister = ref(false)

// Datos del formulario de login
const loginEmail = ref('')
const loginPassword = ref('')

// Datos del formulario de registro
const registerEmail = ref('')
const registerName = ref('')
const registerPassword = ref('')
const registerPasswordConfirm = ref('')

const auth = useAuthStore()

// Validación de email
const isValidEmail = (val) => {
  const emailPattern = /^(?=[a-zA-Z0-9@._%+-]{6,254}$)[a-zA-Z0-9._%+-]{1,64}@(?:[a-zA-Z0-9-]{1,63}\.){1,8}[a-zA-Z]{2,63}$/
  return emailPattern.test(val) || 'Email no válido'
}

const handleLogin = async () => {
  try {
    loadingLogin.value = true
    
    if (!loginEmail.value || !loginPassword.value) {
      throw new Error('Por favor completa todos los campos')
    }
    
    const success = await auth.login({
      email: loginEmail.value,
      password: loginPassword.value
    })
    
    if (success) {
      $q.notify({
        type: 'positive',
        message: `¡Bienvenido de nuevo!`,
        timeout: 2000,
        progress: true,
        position: 'top'
      })
      
      // Pequeño delay para mostrar la notificación antes de navegar
      await new Promise(resolve => setTimeout(resolve, 1500))
      
      // Navegar al home después de login exitoso
      await navigateTo('/agregar')
    }
  } catch (error) {
    console.error('Login fallido:', error)
    $q.notify({
      type: 'negative',
      message: error.data?.message || error.message || 'Error al iniciar sesión',
      timeout: 3000,
      progress: true,
      position: 'top'
    })
  } finally {
    loadingLogin.value = false
  }
}

const handleRegister = async () => {
  try {
    loadingRegister.value = true
    
    if (registerPassword.value !== registerPasswordConfirm.value) {
      throw new Error('Las contraseñas no coinciden')
    }
    
    const response = await $fetch('http://localhost:8000/api/register', {
      method: 'POST',
      body: {
        email: registerEmail.value,
        name: registerName.value,
        password: registerPassword.value,
        password_confirmation: registerPasswordConfirm.value
      }
    })
    
    $q.notify({
      type: 'positive',
      message: `¡Registro exitoso! Bienvenido ${registerName.value}`,
      timeout: 2000,
      progress: true,
      position: 'top'
    })
    
    // Auto-login después de registro
    await auth.login({
      email: registerEmail.value,
      password: registerPassword.value
    })
    
    // Pequeño delay para mostrar la notificación antes de navegar
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    await navigateTo('/agregar')
  } catch (error) {
    console.error('Registro fallido:', error)
    $q.notify({
      type: 'negative',
      message: error.data?.message || error.message || 'Error en el registro',
      timeout: 3000,
      progress: true,
      position: 'top'
    })
  } finally {
    loadingRegister.value = false
  }
}

const handleForgotPassword = () => {
  $q.dialog({
    title: 'Recuperar contraseña',
    message: 'Ingresa tu email para recibir un enlace de recuperación',
    prompt: {
      model: '',
      type: 'email',
      isValid: val => isValidEmail(val) === true,
      attrs: {
        placeholder: 'tu@email.com'
      }
    },
    cancel: true,
    persistent: true
  }).onOk(async (email) => {
    try {
      $q.loading.show({
        message: 'Enviando enlace de recuperación...'
      })
      
      // Aquí iría la llamada a tu API para recuperar contraseña
      // await $fetch('http://localhost:8000/api/forgot-password', {
      //   method: 'POST',
      //   body: { email }
      // })
      
      // Simulamos un delay de red
      await new Promise(resolve => setTimeout(resolve, 1500))
      
      $q.notify({
        type: 'positive',
        message: '¡Enlace enviado! Revisa tu correo electrónico',
        timeout: 3000,
        progress: true
      })
    } catch (error) {
      $q.notify({
        type: 'negative',
        message: error.data?.message || error.message || 'Error al enviar el enlace',
        timeout: 3000,
        progress: true
      })
    } finally {
      $q.loading.hide()
    }
  })
}
</script>

<style scoped>
.cursor-pointer {
  cursor: pointer;
}
.q-pt-xl {
  padding-top: 10px !important;
}

/* Animación suave para los cambios de formulario */
.q-card {
  transition: all 0.3s ease;
}

.q-form.q-px-sm.q-pt-xl.q-pb-lg{
  padding-bottom:0px !important;
}

.sinpadding{
  padding-bottom:0px !important;
}

.q-card__section--vert{
  padding-bottom: 10px !important;
}
</style>