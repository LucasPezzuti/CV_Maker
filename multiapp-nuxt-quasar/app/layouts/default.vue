<template>
  <div class="q-pa-md">
    <q-layout view="lHh lpr lFf">
      <q-header elevated class="navbar-gradient">
        <q-toolbar>

          <q-avatar size="80px">
            <!--<img src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg">-->
            <img src="localhost:3000/logo.png">
          </q-avatar>

          <q-toolbar-title>
            CVTorta
          </q-toolbar-title>

          <!-- Botón Logout alineado a la derecha -->
          <q-tooltip class="q-ml-auto">auth.name</q-tooltip> <!-- arreglar esto -->
          <q-btn
            flat
            round
            dense
            icon="logout"
            @click="logout"
            class="q-ml-auto"
            color="white"
          >
            <q-tooltip>Salir</q-tooltip>
          </q-btn>
        </q-toolbar>

        <!-- Navbar -->
        <q-tabs
          v-model="tabSeleccionada"
          @update:model-value="irAModulo"
          align="justify"
        >
          <!--<q-tab name="/" label="Inicio" icon="home" />-->
          <!--<q-tab name="/agregar" label="Modificar CV" icon="add" />-->
          <!--<q-tab name="/perfil" label="Ver CV" icon="person" />
          <q-tab name="/calendario" label="Calendario" icon="event" />
          <q-tab name="/programas" label="Programas" icon="restaurant_menu" />-->
        </q-tabs>
      </q-header>

      <q-page-container>
        <slot />
      </q-page-container>
    </q-layout>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '~/stores/auth'

const router = useRouter()
const route = useRoute()
const auth = useAuthStore()

const tabSeleccionada = ref(route.path)

function irAModulo(ruta) {
  if (ruta) {
    router.push(ruta)
  }
}

function logout() {
  auth.clearAuthData()
  router.push('/auth')
}
</script>

<style scoped>
.navbar-gradient {
  background: linear-gradient(135deg, #805ad5 0%, #9f7aea 50%, #d6c2ff 100%) !important;
}

.tabs-gradient {
  background: rgba(255, 255, 255, 0.1) !important;
  backdrop-filter: blur(10px);
}

/* Estilos para las pestañas activas */
:deep(.q-tab--active) {
  color: white !important;
  font-weight: bold;
}

:deep(.q-tab__indicator) {
  background: white !important;
  height: 3px;
}

:deep(.q-tab) {
  color: rgba(255, 255, 255, 0.8) !important;
  transition: all 0.3s ease;
}


</style>