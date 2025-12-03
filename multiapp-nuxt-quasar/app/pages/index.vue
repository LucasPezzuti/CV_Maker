<template>
  <q-page class="q-pa-md">
    <div class="text-h4 q-mb-md">Bienvenido al Planificador de Comidas</div>
    <q-banner class="bg-primary text-white">
      Elegí una opción del menú superior para comenzar.
    </q-banner>
  </q-page>
</template>
<script setup>
definePageMeta({
  layout: 'default',
  middleware: 'auth' // Protege la ruta
})
</script>